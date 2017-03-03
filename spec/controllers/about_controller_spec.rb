require "rails_helper"

RSpec.describe AboutController, type: :controller do
  describe "GET #read" do
    let(:status)  { FactoryGirl.create(:status) }
    let!(:featured_current_events) { FactoryGirl.create(:article, slug:"feature-report-back-from-the-battle-for-sacred-ground", status: status, published_at: Date.current) }
    let!(:featured_strategy_and_analysis) { FactoryGirl.create(:article, slug:"feature-understanding-the-kurdish-resistance-historical-overview-eyewitness-report", status: status, published_at: Date.current)}
    let!(:featured_theory_and_critique) { FactoryGirl.create(:article, slug:"feature-from-democracy-to-freedom", status: status, published_at: Date.current) }
    let!(:featured_classics) { FactoryGirl.create(:article, slug:"why-we-dont-make-demands", status: status, published_at: Date.current) }

    it "assigns all instance variables" do
      get :read

      expect(assigns[:featured_current_events]).to eq(featured_current_events)
      expect(assigns[:featured_strategy_and_analysis]).to eq(featured_strategy_and_analysis)
      expect(assigns[:featured_theory_and_critique]).to eq(featured_theory_and_critique)
      expect(assigns[:featured_classics]).to eq(featured_classics)

      expect(assigns[:html_id]).to eq("page")
      expect(assigns[:body_id]).to eq("read")
    end
  end

  describe "GET #post_order_success" do
    it "assigns all instance variables" do
      ordernum = "1"

      get :post_order_success, params: { ordernum: ordernum }

      expect(assigns[:html_id]).to eq("page")
      expect(assigns[:body_id]).to eq("store")
      expect(assigns[:title]).to eq("Post-Order Glow")
      expect(assigns[:order_id]).to eq(ordernum)
    end
  end
end
