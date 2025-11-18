class Day9
  def self.part1(input)
    fs = Day9::FileSystem.from_diskmap(input)
    fs.compact!
    fs.checksum
  end

  def self.part2(input)
    "TBD"
  end

  class FileSystem
    FREESPACE = '.'

    def initialize(input)
      @blocks = input.is_a?(Array) ? input : input.split(//).map{ |char| char.ord.between?('0'.ord, '9'.ord) ? char.to_i : char }
    end

    def all_free_space_contiguous?
      first_free_space = @blocks.index(FREESPACE)
      last_file_space = @blocks.rindex{ |e| e != FREESPACE }
      !first_free_space or first_free_space > last_file_space
    end

    def checksum
      @blocks.map.with_index do |filenumber, index|
        (filenumber == FREESPACE) ? 0 : filenumber * index
      end.sum
    end

    def compact!(limit: nil)
      compaction_count = 0
      until all_free_space_contiguous? or (limit and compaction_count >= limit)
        first_free_space = @blocks.index(FREESPACE)
        last_file_space = @blocks.rindex{ |e| e != FREESPACE }
        @blocks[first_free_space] = @blocks[last_file_space]
        @blocks[last_file_space] = FREESPACE
        compaction_count += 1
      end
    end

    def compact_once!
      compact!(limit: 1)
    end

    def to_s
      @blocks.join()
    end

    def self.from_diskmap(str)
      instructions = str.split(//).map(&:to_i)
      file_number = -1
      blocks = []
      instructions.each_slice(2) do |slice|
        file_length, freespace_length = slice
        file_number += 1
        file_length.times{ blocks << file_number }
        freespace_length.times{ blocks << FREESPACE } if freespace_length
      end
      FileSystem.new(blocks)
    end
  end
end
