class Volunteer
    attr_reader :id
    attr_accessor :name, :project_id

    def initialize(attributes)
        @id = attributes.fetch(:id)
        @name = attributes.fetch(:name)
        @project_id = attributes.fetch(:project_id)
    end

    def save
        result = DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{@name}', #{@project_id} RETURNING id;)")
        @id = result.first.fetch("id").to_i
    end

end