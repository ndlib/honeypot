class AddImage
  include ActiveModel::Validations
  attr_reader :image, :application_id, :group_id, :item_id

  validates :image, presence: true
  validates :application_id, presence: true
  validates :group_id, presence: true, numericality: true
  validates :item_id, presence: true, numericality: true

  def initialize(params)
    @image = params[:image]
    @application_id = params[:application_id]
    @group_id = params[:group_id]
    @item_id = params[:item_id]
  end

  def upload!
    if valid?
      copy_image
      convert_image
      true
    else
      false
    end
  end

  def filepath
    File.join(basepath, filename)
  end

  def image_set
    @image_set ||= ImageSet.new(filepath)
  end

  private
    def filename
      SecureRandom.urlsafe_base64 + File.extname(image.original_filename)
    end

    def basepath
      File.join(application_path, group_path, item_path)
    end

    def application_path
      application_id
    end

    def group_path
      id_partition(group_id)
    end

    def item_path
      id_partition(item_id)
    end

    def id_partition(id)
      ("%06d" % id).scan(/\d{3}/).join("/")
    end

    def copy_image
      CopyImage.call(image, image_set)
    end

    def convert_image
      ConvertImage.call(image_set)
    end
end
