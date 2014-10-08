class Profile
  attr_reader :email, :name, :job_info, :success, :memberships

  def initialize person
    if person
      @email = person['email']
      @name = person['name']
      @success = person['success']
      @job_info = []
      @memberships = []

      person['occupations'].each do |occupation|
        @job_info << [occupation['job_title'], occupation['company']]
      end

      person['memberships'].each do |membership|
        @memberships << [membership['site_name'], membership['profile_url']]
      end
    end
  end

  def inspect
    puts ''
    puts self.email
    puts "Name: #{self.name}"

    self.job_info.each do |job|
      puts "Position: #{job[0]}"
      puts "Company: #{job[1]}"
    end

    self.memberships.each do |membership|
      puts "#{membership[0]} - #{membership[1]}"
    end
  end
end