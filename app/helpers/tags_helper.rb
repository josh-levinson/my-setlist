module TagsHelper
  def text_color_for_background(background_color)
    # Convert hex to RGB
    r, g, b = background_color.match(/^#(..)(..)(..)$/).captures.map(&:hex)

    # Calculate relative luminance
    # Using the formula: 0.299R + 0.587G + 0.114B
    luminance = (0.299 * r + 0.587 * g + 0.114 * b) / 255

    # Return black for light colors, white for dark colors
    luminance > 0.5 ? '#000000' : '#FFFFFF'
  end
end
