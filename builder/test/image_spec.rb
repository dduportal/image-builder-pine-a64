require 'serverspec'
set :backend, :exec

describe "SD-Card Image" do
  let(:image_path) { return '/sd-card-pine-a64.img' }

  it "exists" do
    image_file = file(image_path)

    expect(image_file).to exist
  end

  context "Partition table" do
    # let(:stdout) { command("guestfish add #{image_path} : run : list-filesystems").stdout }
    let(:stdout) { command("fdisk -l #{image_path} | grep '^/sd-card'").stdout }


    it "has 7 partitions" do
      partitions = stdout.split(/\r?\n/)

      expect(partitions.size).to be 8
    end

    it "has a root-partition with a sda1 W95 FAT16 filesystem" do
      expect(stdout).to contain('^.*\.img1 .*W95 FAT16 \(LBA\)$')
    end
    it "has a root-partition with a sda2 Extended filesystem" do
      expect(stdout).to contain('^.*\.img2 .*Extended$')
    end
    it "has a root-partition with a sda5 Non-FS data filesystem" do
      expect(stdout).to contain('^.*\.img5 .*Non-FS data$')
    end
    it "has a root-partition with a sda6 Non-FS data filesystem" do
      expect(stdout).to contain('^.*\.img6 .*Non-FS data$')
    end
    it "has a root-partition with a sda7 Non-FS data filesystem" do
      expect(stdout).to contain('^.*\.img7 .*Non-FS data$')
    end
    it "has a root-partition with a sda8 Non-FS data filesystem" do
      expect(stdout).to contain('^.*\.img8 .*Non-FS data$')
    end
    it "has a root-partition with a sda9 Non-FS data filesystem" do
      expect(stdout).to contain('^.*\.img9 .*Non-FS data$')
    end
    it "has a root-partition with a sda10 Linux filesystem" do
      expect(stdout).to contain('^.*\.img10 .*Linux$')
    end
    #FIXME:
    # it "has a root-partition with a sda10 ext4 filesystem" do
    #   expect(stdout).to contain('sda10: ext4')
    # end
  end
end
