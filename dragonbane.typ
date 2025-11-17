// SPDX-License-Identifier: MIT
// Sample supplement for Dragonbane using Typst

#import "dragonbane-supplement.typ": *
#show: conf

#set document(
  author: "Antonio Caggiano",
  date: datetime(day: 14, month: 11, year: 2025),
  description: "A typst-template for Dragonbane",
  keywords: "template",
  title: "Dragonbane Supplement",
)

#title()

#dragon_line()
#subtitle[A TYPST-TEMPLATE FOR DRAGONBANE]

#align(center, block(width: 65%, [
  Version #version(0, 1, 0)

  == AUTHOR:
  Antonio Caggiano

  == CREDITS:

  Derived from the #link("https://github.com/sibling-dex/dragonbane-latex-template", [LaTeX template]) by Sibling Dex.

  #link("https://www.deviantart.com/esther-sanz/art/Old-Scroll-Texture-II-114214631", ["Old Scroll Texture"]) by Esther Sanz (#link("http://creativecommons.org/licenses/by/3.0/", [CC BY 3.0]))

  #link("https://www.publicdomainpictures.net/en/view-image.php?image=394750&picture=parchment-paper-vintage-retro", ["Pergament Papier Vintage Retro"]) by Andrea Stöckel (Public Domain).

  "The Jabberwocky" by John Tenniel (Public Domain).

  "Knight" designed by #link("www.freepik.com", "Freepik.com").

  This game supplement was created under Fria Ligan AB's #link("https://freeleaguepublishing.com/wp-content/uploads/2023/11/Dragonbane-License-Agreement.pdf", [Dragonbane Third Party Supplement License]) to be used with the core rules of _Dragonbane_.

  This game supplement is neither affiliated with, sponsored, or endorsed by Fria Ligan AB.
]))

#place(bottom + center, image("img/dragonbane-license-logo-red.png", width: 50%))

#part_image([Instructions], [Part I], "img/jabberwocky.jpg")

#pad(demon_line(), top: -24pt, bottom: -24pt)
= Features

#columns(2, [

  "Quotes are useful to provide a short and flavourful introduction to a topic at the top of a new section or chapter."

  -- The Author (always give credit)

  == Parts

  Using `part_image(...)` generates a full-page heading with space for an image, as seen on the page before this one. Use the `part_image(...)` to set the image used on the page.

  #colbreak()

  == Chapters
  The `chapter()` command produces a large, accent-coloured, fancy title, such as the one on this page. Apart from its decoration, the chapter heading looks like a _level 1 heading_.
])


= Columns

#columns(2, [
  The `columns(2, ...)` command can generate a 2-column layout. If you want to break a column early, use the `colbreak()` command.

  == Level 2 heading

  The _level 2 heading_ is bold-faced, left-aligned, and you can see it above this paragraph. Use them to divide your longer texts into smaller chunks to provide a nice orientation for the reader.

  == Paragraphs

  The smallest defined division in this document class is the paragraph.

  #colbreak()

  == Lists

  You can use dashes to define a a simple list entry.

  - *Bold Item:* To add a bold keyword to the beginning of an item, use the `*...*` syntax.

  #demon_list[
    - *Color Item:* To make the bold keyword green, use the `demon_list(...)` command. This is often used in lists that list the important aspects of a location.
  ]
  #secret_list[
    - *Secret Item:* You can make the keyword red and italic by using the `secretitem(...)` command. This is often used to list a secret or hidden feature of a location.
  ]
  #color_list(color: blue, [
    - *Color Item:*  You can make the keyword a custom color by using the `color_list(color: blue, ...)` command and specify the color you prefer.
  ])
])

#colbreak()

#pad(demon_line(), top: -24pt, bottom: -24pt)
= Boxes

#columns(2, [
  There are various types of box provided by this template. These are commands that can be used to highlight special rules or important information in a compact way. These boxes are not floats but are placed as part of the text. Therefore, they can be placed both inside a `columns` command, to produce a one-column wide box, or outside, to create a two-column spanning box.

  #colbreak()

  #dragon_box("Dragonbox", [
    - *These Rules Are:* Obligatory

    This can be created with the `dragon_box(...)` command. It can be used to highlight important information in a compact and noticeable way.

    It can be used, for example, to typeset a Heroic Ability. In that case, you can use a list, as above, to note the Willpower cost for the ability.
  ])
])

#dragon_box("Wide Boxes", [
  #columns(2, [
    Both `dragon_box(...)` and `demon_box(...)` can be used outside a `columns(...)` command to make it span the whole page width. When using text inside a wide box, it is good practice to use `columns(...)` inside the box to get a two column layout in the box and prevent overly long lines.

    #colbreak()

    == Subsection

    Lower level headings such as this one and paragraphs can be used inside boxes.

    #par[
      *PARAGRAPH:* Using these headings can help make the text inside a box more ordered and provide a better overview.
    ]
  ])
])

#table_box("Tablebox", table(
  align: (center, left, center, left),
  columns: (10%, 14%, 15%, auto),

  table.header([*DICE*], [*LABEL*], [*ALIGNMENT*], [*DESCRIPTION*]),
  table.hline(),

  [1],
  [Dice],
  [center],
  [If you want a table to be rollable, use the first column as the die or dice column. Give it a header denoting the die/dice used, and number the rows. ],
  table.hline(stroke: 0.5pt),

  [2],
  [Label],
  [left],
  [The first or second column of a table should be the label of the entry. This gives a short and meaningful name to the entry in the row. ],
  table.hline(stroke: 0.5pt),

  [3],
  [Score],
  [center],
  [You can add several narrower columns for short, standardized scores, such as price, availability, durability, etc. ],
  table.hline(stroke: 0.5pt),

  [4],
  [Description],
  [left],
  [The typically last column in a table is a longer description of the entry. Use a breaking alignment for this, so the description can be more than one line. ],
  table.hline(stroke: 0.5pt),
))

#colbreak()

#columns(2, [
  #character_box(picture: "img/knight.png", "Character's Name", [
    The command `character_box(...)` can be used to create a box for a character. It includes a header for the character's name, content which can include stats, abilities, background information, and optionally a picture.

    #table(
      align: (left),
      columns: 100%,
      table.hline(stroke: 0.5pt),
      grid(
        columns: (50%, 50%),
        align: (left, right),
        [*Movement:* 14], [*HP*: 16],
      ),
      table.hline(stroke: 0.5pt),
      grid(
        columns: (50%, 50%),
        align: (left, right),
        [*Armor:* Plate Armor (6)], [*WP*: 20],
      ),
      table.hline(stroke: 0.5pt),
      [*Skills:* Sword 13, Awareness 12],
      table.hline(stroke: 0.5pt),
      [*Weapons:* Longsword],
      table.hline(stroke: 0.5pt),
    )
  ])
])
