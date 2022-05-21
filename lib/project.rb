class Project
    attr_reader :id, :title

    def initialize(attributes)
        @title = attributes.fetch(:title)
        @id = attributes.fetch(:id)
    end

    def save
        result = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;")
        @id = result.first().fetch("id").to_i
    end

    def self.all
        returned_projects = DB.exec("SELECT * FROM projects;")
        projects = []
        returned_projects.each() do |project|
            title = project.fetch("title")
            id = project.fetch("id").to_i
            projects.push(Project.new({:title => title, :id =>id}))
        end
        projects
    end

    def self.find(id)
        project = DB.exec("SELECT * FROM projects WHERE id = #{id};").first
        if project
            title = project.fetch("title")
            id = project.fetch("id").to_i
            Project.new({:title => title, :id => id})
        else
            nil
        end
    end

end