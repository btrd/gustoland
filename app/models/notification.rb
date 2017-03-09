class Notification < ApplicationRecord
  belongs_to :user

  def self.follow(notif_user, action_user)
    notif(notif_user, "#{action_user.name} vous suis", action_user: action_user)
  end

  def self.like(notif_user, action_user, recipe)
    notif(notif_user, "#{action_user.name} a aimé votre recette #{recipe.description}", recipe: recipe)
  end

  def self.book(notif_user, action_user, recipe)
    notif(notif_user, "#{action_user.name} a enregistré votre recette #{recipe.description}", recipe: recipe)
  end

  def self.more(notif_user, action_user, recipe)
    notif(notif_user, "#{action_user.name} demande plus d'infos sur votre recette #{recipe.description}", recipe: recipe)
  end

  def self.comment(notif_user, action_user, recipe)
    notif(notif_user, "#{action_user.name} a commenté votre recette #{recipe.description}", recipe: recipe)
  end

  def self.notif(notif_user, content, action_user: nil, recipe: nil)
    n = notif_user.notifications.new(content: content)
    n.ref_recipe_id = recipe.id      if recipe
    n.ref_user_id   = action_user.id if action_user
    n.save
  end
end