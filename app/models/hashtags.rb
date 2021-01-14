class Hashtags
  class << self
    def general_tags
      file_contents = File.read("lib/hashtags/general.txt")
      file_contents.split("\n")
    end

    # prints a selection of 11 tags from the general list
    def print
      output = ""
      general_tags.sample(11).each do |tag|
        output << "##{tag} "
      end
      output.strip
    end
  end
end
