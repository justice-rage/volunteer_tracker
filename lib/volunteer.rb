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

    def self.all
        returned_volunteers = DB.exec("SELECT * FROM volunteers")
        volunteers = []
        returned_volunteers.each do |volunteer|
            id = volunteer.fetch("id").to_i
            name = volunteer.fetch("name")
            project_id = volunteer.fetch("project_id")
            volunteers.push(Volunteer.new({:id => id, :name => name, :project_id => project_id}))
        end
        volunteers
    end

    def self.find(id)
        volunteer = DB.exec("SELECT * FROM volunteers WHERE id = #{id};").first
        if volunteer
        name = volunteer.fetch("name")
        project_id = volunteer.fetch("project_id").to_i
        id = volunteer.fetch("id").to_i
        Volunteer.new({:id => id, :name => name, :project_id => project_id})
        else
            nil
        end
    end

end