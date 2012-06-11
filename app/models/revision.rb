class Revision < ActiveRecord::Base

  belongs_to :page
  belongs_to :user

  after_create :update_page

  def update_page
    self.page.current_revision_id = self.id
    self.page.save()
  end

end
