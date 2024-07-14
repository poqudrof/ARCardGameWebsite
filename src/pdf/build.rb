require 'prawn'
require 'prawn/emoji'
require 'json'
require 'yaml'

class CarteJouerPDF
  def initialize(font_path, rubik_font_path, roles)
    @roles = roles
    @pdf = Prawn::Document.new
    @pdf.font_families.update(
      "OpenSans" => {
        normal: font_path,
        bold: font_path
      },
      "Galada" => {
        normal: rubik_font_path
      }
    )
    @pdf.font("OpenSans")
  end

  def add_carte_from_json(json_data, sound_icon_path)
    cartes = JSON.parse(json_data)
    @pdf.move_up(-50)

    cartes.each_slice(2) do |slice|
      slice.each_with_index do |carte, index|
        x_position = index.even? ? 0 : mm_to_pt(70)
        y_position = @pdf.cursor
  
        if y_position < mm_to_pt(88)
          @pdf.start_new_page
          @pdf.move_up(-50)
          y_position = @pdf.cursor
        end        
  
        @pdf.bounding_box([x_position, y_position], width: mm_to_pt(62), height: mm_to_pt(88)) do
          role = get_role_title_from_id(carte["card_id"])
          draw_rounded_card
          draw_card_code(carte["card_id"])
          draw_card_role(role)
          draw_card_title(carte["title"])
          draw_card_lines(carte["lines"])
          draw_footer(carte, sound_icon_path)
        end

        @pdf.move_up mm_to_pt(88) if index.even?
      end

      @pdf.move_up -10
    end
  end

  def generate_pdf(file_name)
    @pdf.render_file(file_name)
  end

  private

  # Conversion de mm en points (1 mm = 2.83465 points)
  def mm_to_pt(mm)
    mm * 2.83465
  end

  def draw_rounded_card
    @pdf.rounded_rectangle [0, @pdf.cursor], @pdf.bounds.width, @pdf.bounds.height, 5
    @pdf.stroke
  end

  def draw_logo(carte_logo_path, tier)
    @pdf.image carte_logo_path, at: [5, @pdf.cursor - 5], width: 16, height: 16
    @pdf.image carte_logo_path, at: [25, @pdf.cursor - 5], width: 16, height: 16 if tier > 1
    @pdf.image carte_logo_path, at: [45, @pdf.cursor - 5], width: 16, height: 16 if tier > 2
  end

  def draw_card_background(fond_path)
    @pdf.image fond_path, at: [0, @pdf.cursor], width: @pdf.bounds.width, height: @pdf.bounds.height
  end

  def draw_card_content(titre, identifiant, image_path, texte)
    @pdf.move_down 15
    @pdf.text titre, align: :center, size: 14, style: :bold
    @pdf.text_box identifiant, size: 14, width: 40, align: :center, at: [@pdf.bounds.right - identifiant.length * 1.6 - 46, @pdf.bounds.top - 4]
    @pdf.move_down 10
    @pdf.image image_path, fit: [@pdf.bounds.width - 10, @pdf.bounds.height - 60], position: :center
    @pdf.move_down 30
    @pdf.text_box texte, at: [@pdf.bounds.left + 20, @pdf.bounds.bottom + 90], width: @pdf.bounds.width - 40, height: @pdf.bounds.height - 60, align: :center, size: 10
  end

  def draw_card_code(card_id)
    @pdf.text_box card_id, size: 8, at: [@pdf.bounds.right - 60, @pdf.bounds.top - 5], width: 50, align: :right
  end

  def draw_card_title(title)
    @pdf.move_down 20
    @pdf.text title || "", align: :center, size: 14, style: :bold
  end

  def draw_card_role(card_role)
    @pdf.font("Galada")
   # @pdf.font("RubikLight") do
      @pdf.text_box card_role, size: 12, at: [0, @pdf.bounds.top - 30], width: @pdf.bounds.width, align: :center
   # end

    @pdf.font("OpenSans")
  end

  def draw_card_lines(lines)
    @pdf.move_down 40
    lines.each do |line|
      @pdf.text line["line"] || "", size: 10, align: :center
      @pdf.move_down 6
    end
  end

  def draw_footer(carte, sound_icon_path)
    @pdf.move_down 20
    @pdf.text_box "RXX", at: [0, @pdf.bounds.bottom + 50], width: 50, height: 12, align: :left, size: 8 if carte["answer"]
    @pdf.text_box "AXX", at: [50, @pdf.bounds.bottom + 50], width: 50, height: 12, align: :left, size: 8 if carte["tip"]
    if carte["voiceover"]
      @pdf.image sound_icon_path, at: [@pdf.bounds.right - 30, @pdf.bounds.bottom + 50], width: 16, height: 16
    end
  end

  # Function to get the role title from a complete ID
  def get_role_title_from_id(complete_id)
    role = @roles.find { |r| r['attributes']['short_name'][0, 2] == complete_id[0, 2] }
    if role
      role['attributes']['title']
    else
      "Role not found"
    end
  end
end

# Exemple d'utilisation
font_path = "OpenSans-VariableFont_wdth,wght.ttf" # Remplacez par le chemin vers votre police TTF
light_font_path = "Galada-Regular.ttf" # Remplacez par le chemin vers votre police Ruby Light TTF
sound_icon_path = "sound.png" # Remplacez par le chemin vers l'icône de son

# JSON
roles = JSON.parse(File.read("card-roles.json"))["data"]
p roles
carte_pdf = CarteJouerPDF.new(font_path, light_font_path, roles)

# JSON
json_data = File.read("cartes.json")

carte_pdf.add_carte_from_json(json_data, sound_icon_path)

carte_pdf.generate_pdf("cartes.pdf")
