require 'prawn'
require 'prawn/emoji'
require 'json'
require 'open-uri'

class CarteJouerPDF
  def initialize(font_path)
    @pdf = Prawn::Document.new
    @pdf.font_families.update(
      "OpenSans" => {
        normal: font_path,
        bold: font_path
      }
    )
    @pdf.font("OpenSans")
  end

  def add_carte_from_json(json_data, sound_icon_path)
    cartes = JSON.parse(json_data)
    
    cartes.each do |carte|
      @pdf.start_new_page

      draw_card(carte, sound_icon_path)
    end
  end

  def generate_pdf(file_name)
    @pdf.render_file(file_name)
  end

  private

  def draw_card(carte, sound_icon_path)
    draw_card_code(carte["card_id"])
    draw_card_title(carte["title"])
    draw_card_lines(carte["lines"])
    draw_footer(carte, sound_icon_path)
  end

  def draw_card_code(card_id)
    @pdf.text_box card_id, size: 8, at: [@pdf.bounds.right - 50, @pdf.bounds.top], width: 50, align: :right
  end

  def draw_card_title(title)
    @pdf.move_down 20
    @pdf.text title || "", align: :center, size: 14, style: :bold
  end

  def draw_card_lines(lines)
    @pdf.move_down 20
    lines.each do |line|
      @pdf.text line["line"] || "", size: 12
      @pdf.move_down 10
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
end

# Exemple d'utilisation
font_path = "OpenSans-VariableFont_wdth,wght.ttf" # Remplacez par le chemin vers votre police TTF
sound_icon_path = "sound_icon.png" # Remplacez par le chemin vers l'icône de son

carte_pdf = CarteJouerPDF.new(font_path)

json_data = File.read("cartes.json")[0...3]
carte_pdf.add_carte_from_json(json_data, sound_icon_path)
carte_pdf.generate_pdf("cartes.pdf")
