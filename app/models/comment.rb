class Comment < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :party

  def analyze_sentiment
    results = AlchemyAPI.search(:sentiment_analysis, :text => self.content)
    self.score = results["score"]
    self.save
  end
end
