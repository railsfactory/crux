# this clas was inspired (heavily) from the mephisto admin architecture

module Spree
  module Admin
    class OverviewController < BaseController
      before_filter :check_json_authenticity, :only => :get_report_data
      before_filter :verify_user
      #todo, add rss feed of information that is happening

      def index
        @show_dashboard = show_dashboard
        return unless @show_dashboard
        p = {:from => (Time.new().to_date  - 1.week).to_s(:db), :value => "Count"}
        @orders_by_day = orders_by_day(p)
        @orders_line_total = orders_line_total(p)
        @orders_total = orders_total(p)
        @orders_adjustment_total = orders_adjustment_total(p)
        @orders_credit_total = orders_credit_total(p)
        @best_selling_variants = best_selling_variants
        @top_grossing_variants = top_grossing_variants
        @last_five_orders = last_five_orders
        @biggest_spenders = biggest_spenders
        @out_of_stock_products = out_of_stock_products
        @best_selling_taxons = best_selling_taxons
        @pie_colors = [ "#0093DA", "#FF3500", "#92DB00", "#1AB3FF", "#FFB800"]
      end

      def get_report_data
        opts = case params[:name]
        when "7_days" then {:from => (Time.new().to_date - 1.week).to_s(:db)}
        when "14_days" then {:from => (Time.new().to_date - 2.week).to_s(:db)}
        when "this_month" then {:from => Date.new(Time.now.year, Time.now.month, 1).to_s(:db), :to => Date.new(Time.now.year, Time.now.month, -1).to_s(:db)}
        when "last_month" then {:from => (Date.new(Time.now.year, Time.now.month, 1) - 1.month).to_s(:db), :to => (Date.new(Time.now.year, Time.now.month, -1) - 1.month).to_s(:db)}
        when "this_year" then {:from => Date.new(Time.now.year, 1, 1).to_s(:db)}
        when "last_year" then {:from => Date.new(Time.now.year - 1, 1, 1).to_s(:db), :to => Date.new(Time.now.year - 1, 12, -1).to_s(:db)}
        end
        case params[:report]
        when "orders_by_day"
          opts[:value] = params[:value]
          render :js => "[[" + orders_by_day(opts).map { |day| "['#{day[0]}',#{day[1]}]" }.join(",") + "]]"
        when "orders_totals"
          render :js => [:orders_total => orders_total(opts).to_i, :orders_line_total => orders_line_total(opts).to_i,
            :orders_adjustment_total => orders_adjustment_total(opts).to_i, :orders_credit_total => orders_credit_total(opts).to_i ].to_json
        end
      end
      private
  
      def show_dashboard
        Spree::Order.count > 50
      end

      def conditions(params)
        if params.key? :to
          ["completed_at >= ? AND completed_at <= ? AND id in (?)", params[:from], params[:to],store_orders]
        else
          ["completed_at >= ? AND id in (?)", params[:from],store_orders]
        end
      end

      def fill_empty_entries(orders, params)
        from_date = params[:from].to_date
        to_date = (params[:to] || Time.now).to_date
        (from_date..to_date).each do |date|
          orders[date] ||= []
        end
      end

      def orders_by_day(params)
        if params[:value] == "Count"
          orders = Spree::Order.select(:created_at).where(conditions(params))
          orders = orders.group_by { |o| o.created_at.to_date }
          fill_empty_entries(orders, params)
          orders.keys.sort.map {|key| [key.strftime('%Y-%m-%d'), orders[key].size ]}
        else
          orders = Spree::Order.select([:created_at, :total]).where(conditions(params))
          orders = orders.group_by { |o| o.created_at.to_date }
          fill_empty_entries(orders, params)
          orders.keys.sort.map {|key| [key.strftime('%Y-%m-%d'), orders[key].inject(0){|s,o| s += o.total} ]}
        end
      end

      def orders_line_total(params)
        Spree::Order.sum(:item_total, :conditions => conditions(params))
      end

      def orders_total(params)
        Spree::Order.sum(:total, :conditions => conditions(params))
      end

      def orders_adjustment_total(params)
        Spree::Order.sum(:adjustment_total, :conditions => conditions(params))
      end

      def orders_credit_total(params)
        Spree::Order.sum(:credit_total, :conditions => conditions(params))
      end

      def best_selling_variants
        cond=["order_id in (?)",store_orders]
        li= Spree::LineItem.sum(:quantity, :group => :variant_id,:limit=>5,:conditions=>cond)
        variants = li.map do |v|
          variant = Spree::Variant.find(v[0])
          [variant.name, v[1] ]
        end
        variants.sort { |x,y| y[1] <=> x[1] }
      end

      def store_orders
        owner_orders=Spree::StoreownerOrder.find_all_by_store_owner_id(current_user.store_owner).map(&:order_id)
        return owner_orders
      end

      def top_grossing_variants
        cond=["order_id in (?)",store_orders]
        quantity = Spree::LineItem.sum(:quantity, :group => :variant_id, :limit => 5,:conditions=>cond)
        prices = Spree::LineItem.sum(:price, :group => :variant_id, :limit => 5,:conditions=>cond)
        variants = quantity.map do |v|
          variant = Spree::Variant.find(v[0])
          [variant.name, v[1] * prices[v[0]]]
        end
        variants=variants.compact
        variants.sort { |x,y| y[1] <=> x[1] }
      end

      def best_selling_taxons
        taxonomy = Spree::Taxonomy.find_by_domain_url(current_user.domain_url)
        taxons =  Spree::Taxon.connection.select_rows("select t.name, count(li.quantity) from spree_line_items li inner join spree_variants v on
           li.variant_id = v.id inner join spree_products p on v.product_id = p.id inner join spree_products_taxons pt on p.id = pt.product_id
           inner join spree_taxons t on pt.taxon_id = t.id where t.taxonomy_id = #{taxonomy.id} group by t.name order by count(li.quantity) desc limit 5;") if taxonomy.present?
      end

      def last_five_orders
        order = Spree::Order.includes(:line_items).where("completed_at IS NOT NULL").order("completed_at DESC").limit(5)
        orders=order.where('id in (?)',store_orders )
        orders.map do |o|
          qty = o.line_items.inject(0) {|sum,li| sum + li.quantity}
          [o.email, qty, o.total]
        end
      end

      def biggest_spenders
        spenders = Spree::Order.sum(:total, :group => :user_id, :limit => 5, :order => "sum(total) desc", :conditions =>["completed_at is not null AND user_id is not null AND id in (?)",store_orders])
        spenders = spenders.map do |o|
          orders = Spree::User.find(o[0]).orders
          qty = orders.size
          [orders.first.email, qty, o[1]]
        end
        spenders.sort { |x,y| y[2] <=> x[2] }
      end

      def out_of_stock_products
        Spree::Product.where(:count_on_hand => 0,:domain_url=>current_user.domain_url).limit(5)
      end
  
      def verify_user
        if (request.url.include?(APP_CONFIG['domain_url']) || request.url.include?(APP_CONFIG['secure_domain_url']))
          redirect_to  admin_users_path
        end
      end

    end
  end
end
