# generated with VANTED V2.7.2 at Tue Feb 16 22:00:27 CET 2021
graph [
  graphbackgroundcolor "#ffffff"
  sbgn [
    role "PROCESSDESCRIPTION"
  ]
  directed 1
  node [
    id 1
    zlevel -1

    graphics [
      x 145.0
      y 35.0
      w 80.0
      h 40.0
      fill "#FFFFFF"
      outline "#000000"
      frameThickness 2.0
      gradient 0.0
      opacity 1.0
      rounding 15.0
      type "rectangle"
    ]
    label "C"
    labelgraphics [
      alignment "center"
      anchor "c"
      color "#000000"
      fontName "Arial"
      fontSize 14
      fontStyle "plain"
      labelOffset [
        x 0.0
        y 0.0
      ]
      type "text"
    ]
    sbgn [
      glyphid "glyph1"
      role "MACROMOLECULE"
    ]
  ]
  node [
    id 2
    zlevel -1

    graphics [
      x 55.0
      y 135.0
      w 80.0
      h 40.0
      fill "#B1D992"
      outline "#000000"
      frameThickness 2.0
      gradient 0.0
      opacity 1.0
      rounding 15.0
      type "rectangle"
    ]
    label "A"
    labelgraphics [
      alignment "center"
      anchor "c"
      color "#000000"
      fontName "Arial"
      fontSize 14
      fontStyle "plain"
      labelOffset [
        x 0.0
        y 0.0
      ]
      type "text"
    ]
    sbgn [
      glyphid "glyph2"
      role "MACROMOLECULE"
    ]
  ]
  node [
    id 3
    zlevel -1

    graphics [
      x 145.0
      y 135.0
      w 24.0
      h 24.0
      fill "#FFFFFF"
      outline "#000000"
      frameThickness 2.0
      gradient 0.0
      opacity 1.0
      rounding 0.0
      type "rectangle"
    ]
    sbgn [
      glyphid "glyph4"
      role "PROCESS"
    ]
  ]
  node [
    id 4
    zlevel -1

    graphics [
      x 225.0
      y 135.0
      w 40.0
      h 40.0
      fill "#FFFFFF"
      outline "#000000"
      frameThickness 2.0
      gradient 0.0
      opacity 1.0
      rounding 0.0
      type "de.ipk_gatersleben.ag_nw.graffiti.plugins.shapes.SourceSinkShape"
    ]
    sbgn [
      glyphid "glyph3"
      role "SOURCESINK"
    ]
  ]
  edge [
    id 5
    source 2
    target 3
    SBGN [
      BendIn "121.0;135.0"
    ]
    graphics [
      fill "#000000"
      outline "#000000"
      Line [
        point [ x 0.0 y 0.0 ]
        point [ x 121.0 y 135.0 ]
        point [ x 0.0 y 0.0 ]
      ]
      arrow "none"
      frameThickness 1.5
      gradient 0.0
      opacity 1.0
      rounding 5.0
      type "org.graffiti.plugins.views.defaults.PolyLineEdgeShape"
      thickness 15.0
    ]
    sbgn [
      glyphid "arc2"
      role "CONSUMPTION"
    ]
  ]
  edge [
    id 6
    source 3
    target 4
    SBGN [
      BendOut "169.0;135.0"
    ]
    graphics [
      fill "#000000"
      outline "#000000"
      Line [
        point [ x 0.0 y 0.0 ]
        point [ x 169.0 y 135.0 ]
        point [ x 0.0 y 0.0 ]
      ]
      arrow "last"
      frameThickness 1.5
      gradient 0.0
      opacity 1.0
      rounding 5.0
      type "org.graffiti.plugins.views.defaults.PolyLineEdgeShape"
      thickness 15.0
    ]
    sbgn [
      glyphid "arc3"
      role "PRODUCTION"
    ]
  ]
  edge [
    id 10
    source 1
    target 3
    graphics [
      fill "#000000"
      outline "#000000"
      arrow "last"
      arrowheadstyle "inhibitor"
      frameThickness 1.5
      gradient 0.0
      opacity 1.0
      rounding 5.0
      thickness 15.0
    ]
    sbgn [
      role "INHIBITION"
    ]
  ]
]
