# Includer will be used to include Modeleevee into
# existing models.
#
# In a app the coder might integrate Modeleevee 
# with a existing model by placing the 
# 'include Modeleevee' directive in the model.
#
# class Model < ActiveRecord::Base
#   include Modeleevee
#   attr_accessible :favorite_pose, :stage_name
#   ...
#   def vogue
#     ...
#   end
#   ...
# end
#
# During tests we will include Modeleevee into
# a Model by extending it with the Includer and
# executing the, then newly attained, 
# do_include(obj) class method.

module Includer
  # extending the Includer into a Model will
  # result in do_include posing as a class_method
  def do_include(obj)
   include(obj)
  end
end

# TODO: find a more elegant way to override this
module Internals
  def do_generate_unique_id
    generate_unique_id
  end

  def does_id_exist? me
    id_already_exists? me
  end
end
