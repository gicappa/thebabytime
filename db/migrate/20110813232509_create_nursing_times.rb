class CreateNursingTimes < ActiveRecord::Migration
  def change
    create_table :nursing_times do |t|
      t.datetime :start
      t.datetime :end
      t.string :breast

      t.timestamps
    end
  end
end
