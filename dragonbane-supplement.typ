// SPDX-License-Identifier: MIT
// Dragonbane Supplement Template for Typst

#import "@preview/cetz:0.4.2"

#let demon_green = rgb(34, 114, 98)
#let dragon_red = rgb(231, 47, 50)
#let sand = rgb(232, 219, 191)
#let burned_sand = rgb(210, 190, 160)
#let scroll_brown = rgb(85, 34, 0)
#let stain_brown = rgb(102, 85, 45)
#let bone_white = rgb(245, 242, 235)

// Centered subtitle text in Colus with bold styling.
#let subtitle(content) = {
  align(center, text(
    content,
    fill: black,
    size: 26pt,
    weight: "extrabold",
    font: "Colus",
    stroke: 0.5pt,
  ))
}

// Raw drawing routine for the four-pointed star list marker.
#let fourstar_mark(style) = cetz.draw.compound-path(
  {
    import cetz.draw: *

    let sx = style.scale_x * style.scale * 0.1 // scale
    let sy = style.scale_y * style.scale * 0.1 // scale
    let (a, b, c, d) = (
      (1 * sx, 0),
      (0.0, -1 * sy),
      (-1 * sx, 0.0),
      (0.0, 1 * sy),
    )
    let ab = (0.25 * sx, -0.25 * sy)
    bezier(a, b, ab)
    let bc = (-0.25 * sx, -0.25 * sy)
    bezier(b, c, bc)
    let cd = (-0.25 * sx, 0.25 * sy)
    bezier(c, d, cd)
    let da = (0.25 * sx, 0.25 * sy)
    bezier(d, a, da)
    line(a, b, c, d, close: true)
  },
  fill-rule: "even-odd",
  fill: style.fill,
  stroke: 0pt,
)

// Register and configure the reusable fourstar mark style.
#let register_fourstar_mark(
  color: demon_green,
  thickness: 4pt,
) = {
  import cetz.draw: *
  register-mark("fourstar", style => fourstar_mark(style))
  set-style(
    mark: (
      symbol: "fourstar",
      fill: color,
      anchor: "center",
      // Need to specify these two values or it would not compile
      scale_x: 0.25,
      scale_y: 0.125,
    ),
    stroke: (
      paint: color,
      thickness: thickness,
    ),
  )
}

// Convenience wrapper to draw a fourstar mark on a canvas.
#let fourstar(
  fill: demon_green,
  scale: 1.0,
  scale_x: 1.0,
  scale_y: 1.0,
) = cetz.canvas(fourstar_mark((
  fill: fill,
  scale: scale,
  scale_x: scale_x,
  scale_y: scale_y,
)))

// Generic colored list with matching marker and strong text color.
#let color_list(items, color: black) = {
  set list(marker: fourstar(fill: color))
  show strong: set text(fill: color)
  items
}

// Green list variant for demons and public information.
#let demon_list(items) = color_list(color: demon_green, items)

// Red list variant for secrets or GM-only information.
#let secret_list(items) = color_list(color: dragon_red, items)

// Highlight a skill name in small caps and bold.
#let skill(term) = strong(smallcaps(text(term, fill: black)))

// Horizontal line with a centered fourstar marker.
#let fourstar_line_common(width: auto, color: black, diamond_scale: 1) = cetz.canvas(length: width, {
  import cetz.draw: *

  // Thickness proportional to canvas width
  let thickness = width / 100
  register_fourstar_mark(
    color: color,
    thickness: thickness,
  )
  line(
    (),
    (rel: (1, 0), update: false),
  )
  mark(
    (0.5, 0),
    (0, 0),
    anchor: "center",
    symbol: "fourstar",
    scale: 1.5 * diamond_scale,
  )
})

// Layout helper that stretches a fourstar line to the available width.
#let fourstar_line(color: black, diamond_scale: 1) = layout(
  ly => align(center, fourstar_line_common(
    width: ly.width,
    color: color,
    diamond_scale: diamond_scale,
  )),
)

// Preconfigured green and red fourstar separator lines.
#let demon_line() = fourstar_line(color: demon_green)
#let dragon_line() = fourstar_line(color: dragon_red)

// Raw drawing routine for the spiky line segment.
#let spike_mark(style) = cetz.draw.compound-path(
  {
    import cetz.draw: *
    let s = style.scale
    let (a, b, c, d, e) = (
      (0.5 * s, 0),
      (0.0, -0.5 * s),
      (-1 * s, -0.4 * s),
      (-1 * s, 0.4 * s),
      (0.0, 0.5 * s),
    )
    let ab = (0.2 * s, -0.12 * s)
    bezier(a, b, ab)
    let bc = (-0.2 * s, -0.4 * s)
    bezier(b, c, bc)
    let cd = (-1 * s, 0)
    bezier(c, d, cd)
    let de = (-0.2 * s, 0.4 * s)
    bezier(d, e, de)
    let ea = (0.2 * s, 0.12 * s)
    bezier(e, a, ea)
    line(a, b, c, d, e, close: true)
  },
  fill-rule: "even-odd",
  stroke: 0pt,
)

// Convenience wrapper to draw a spike mark on a canvas.
#let spike(
  fill: demon_green,
  scale: 1.0,
) = cetz.canvas(spike_mark((
  fill: fill,
  scale: scale,
)))

// Continuous spiky line used as background for titles.
#let spiky_line(width: auto, height: auto) = {
  import cetz.draw: *

  register-mark("spike", style => spike_mark(style))
  register_fourstar_mark()

  set-style(
    mark: (symbol: "spike", scale: height.pt() / 200),
  )
  line(
    (-width / 2, 0),
    (width / 2, 0),
    stroke: height * 2.2,
  )
}

// Composite spiky title with main title, subtitle and fourstars.
#let spiky_title(name, subtitle, width: auto) = context {
  let title_box = align(center, block(
    text(font: "Colus", fill: white, size: 28pt, weight: "bold", name),
  ))
  let title_box_size = measure(title_box, width: width)
  let box_width = title_box_size.width
  let box_height = title_box_size.height

  place(
    center,
    dy: -box_height + 3pt,
    layout(ly => cetz.canvas(
      length: ly.width,
      spiky_line(width: box_width, height: box_height),
    )),
  )

  let subtitle_box = align(center, block(
    text(font: "Colus", fill: white, size: 11pt, subtitle),
  ))
  let subtitle_box_size = measure(subtitle_box, width: width)
  let subtitle_box_width = subtitle_box_size.width
  let subtitle_box_height = subtitle_box_size.height

  place(
    center,
    dy: -box_height - 3pt,
    layout(ly => cetz.canvas(
      length: ly.width,
      spiky_line(
        width: subtitle_box_width,
        height: subtitle_box_height,
      ),
    )),
  )

  place(
    center,
    float: false,
    dy: -26pt,
    fourstar(scale: 2.0, scale_x: 2.0),
  )

  place(
    center,
    float: false,
    dy: 24pt,
    fourstar(scale: 2.0, scale_x: 2.0),
  )
  place(
    center,
    dy: -16pt,
    subtitle_box,
  )
  title_box
}

// Spiky header bar for tables and scroll boxes.
#let spiky_table_header(name, color, dy: 0pt, show_long_spike: true) = context {
  layout(ly => {
    let title_box = align(center, text(name, fill: white, font: "Colus"))
    let title_box_size = measure(title_box, width: ly.width)
    let box_width = title_box_size.width
    let box_height = title_box_size.height
    let stroke_dy = if show_long_spike { -3pt } else { 2pt }
    place(
      center,
      dy: stroke_dy,
      clearance: 0pt,
      {
        cetz.canvas(length: ly.width, {
          import cetz.draw: *

          register-mark(
            "fourstar",
            style => fourstar_mark(style),
          )

          set-style(
            mark: (symbol: "diamond", fill: color, scale: 0.01),
            stroke: color,
          )
          line(
            (-box_width / 2 - 16pt, 0),
            (box_width / 2 + 16pt, 0),
            stroke: (paint: color, thickness: box_height + 12pt),
          )

          set-style(
            mark: (symbol: "diamond", fill: color, scale: 0.4),
            stroke: color,
          )
          line(
            (-box_width / 2 - 24pt, 0),
            (box_width / 2 + 24pt, 0),
            stroke: box_height + 8pt,
          )

          if show_long_spike {
            set-style(
              mark: (
                symbol: "fourstar",
                fill: color,
                scale: 128 / ly.width.pt(),
                scale_x: 1,
                scale_y: 0.5,
              ),
              stroke: color,
            )
            line(
              (-ly.width / 2, 0),
              (ly.width / 2, 0),
              stroke: 4pt,
            )
          }
        })
      },
    )
    title_box
  })
}

// Full-width part opener image with overlaid spiky title.
#let part_image(title_name, subtitle, image_source) = {
  let img_stroke = stroke(paint: demon_green, thickness: 12pt)
  align(center, block(stroke: img_stroke, image(image_source)))

  place(
    top + center,
    dy: -12pt,
    spiky_title(title_name, subtitle),
  )
  colbreak()
}

// Scroll-styled framed box with optional spiky header.
#let scroll_box(content, color: black, name: none) = context {
  // Leave some space before the previous element
  if name != none { block() }
  layout(ly => {
    let padded_content = {
      // Leave some space for the spiky header
      if name != none {
        block()
      }
      content
    }
    let content_size = measure(padded_content, width: ly.width - 24pt)
    let inset_value = 12pt
    let b = block(
      padded_content,
      inset: inset_value,
      stroke: (y: stroke(paint: gray, thickness: 1pt)),
      width: ly.width,
    )

    let image_height = content_size.height + inset_value * 2

    place(
      image(
        "img/scroll-light.png",
        fit: "cover",
        width: 100%,
        height: image_height,
      ),
    )
    b
    if name != none {
      place(
        center,
        dy: -image_height - 3pt,
        spiky_table_header(name, color, dy: -image_height, show_long_spike: false),
      )
    }
  })
}

// Red scroll box variant for dragon-themed or danger content.
#let dragon_box(name, content) = scroll_box(name: name, color: dragon_red, content)

// Green scroll box variant for demon-themed or general content.
#let demon_box(name, content) = scroll_box(name: name, content, color: demon_green)

// Scroll box variant for character stat blocks.
#let character_box(name, content) = scroll_box(
  name: text(name, fill: scroll_brown),
  color: burned_sand,
  content,
)

// Standalone spiky header with following table content.
#let table_box(name, content, color: demon_green) = {
  // Leave some space before the previous element
  block()
  spiky_table_header(name, color)
  content
}

// Global document configuration for Dragonbane supplements.
#let conf(doc) = {
  set par(justify: true)

  set page(
    numbering: none,
    background: box(fill: white.transparentize(50%), image("img/pergament-papier-vintage-retro.jpg", width: 100%)),
    margin: (left: 40pt, right: 40pt),
  )

  show title: set align(center)
  show title: set text(
    font: "Colus",
    fill: dragon_red,
    size: 60pt,
    weight: "extrabold",
    stroke: stroke(paint: dragon_red, thickness: 2pt),
  )

  show heading: set text(font: "Colus")
  show heading.where(level: 1): set align(center)
  show heading.where(level: 1): set text(fill: demon_green, size: 30pt)
  set text(font: "Crimson Pro")

  set list(marker: fourstar(fill: black))

  set table(
    stroke: none,
    fill: (x, y) => {
      if calc.rem(y, 2) == 1 {
        scroll_brown.transparentize(80%)
      } else {
        none
      }
    },
  )

  set table.cell(inset: 8pt)

  doc
}
