ActiveRecord::Schema.define do
	#self verbose = false

	# Existing model containing al fields as necessary for Modeleevee to work
	create_table :memos, :id => false do |t|
		t.binary :id,      :limit => 32,   :null => false
		t.string :note,    :limit => 128,  :null => false
		t.timestamps
	end
end
