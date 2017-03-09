class Notification < ApplicationRecord
  belongs_to :user

  def seen!
    self.seen = true
    self.save
  end

  def image
    if self.ref_recipe_id
      image = Recipe.find(self.ref_recipe_id).image
    else
      image = User.find(self.ref_user_id).image
    end
    return image
  end

  def self.follow(notif_user, action_user)
    notif(notif_user, "#{action_user.name} vous suis", action_user: action_user)
  end

  def self.like(action_user, recipe)
    notif(recipe.user, "#{action_user.name} a aimé votre recette #{recipe.description}", recipe: recipe)
  end

  def self.book(action_user, recipe)
    notif(recipe.user, "#{action_user.name} a enregistré votre recette #{recipe.description}", recipe: recipe)
  end

  def self.more(action_user, recipe)
    notif(recipe.user, "#{action_user.name} demande plus d'infos sur votre recette #{recipe.description}", recipe: recipe)
  end

  def self.comment(action_user, recipe)
    notif(recipe.user, "#{action_user.name} a commenté votre recette #{recipe.description}", recipe: recipe)
  end

  def self.notif(notif_user, content, action_user: nil, recipe: nil)
    n = notif_user.notifications.new(content: content)
    n.ref_recipe_id = recipe.id      if recipe
    n.ref_user_id   = action_user.id if action_user
    n.save
  end
end