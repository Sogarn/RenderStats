# Entire page----
page_fillable(
  # Fix broken .visually-hidden css----
  tags$head(
    tags$style(
      HTML("
      .visually-hidden {
        position: absolute !important;
        width: 1px !important;
        height: 1px !important;
        padding: 0 !important;
        margin: -1px !important;
        overflow: hidden !important;
        clip: rect(0, 0, 0, 0) !important;
        white-space: nowrap !important;
        border: 0 !important;
      }
    ")
    )
  ),
  # Actual panels----
  title = "Render Stats",
  navset_card_tab(
    # Moved gamba stats to first tab
    nav_panel(title = "Gamba Stats",
              # Sidebar----
              layout_sidebar(
                title = "Current Tier Gamba Stats",
                # Generate checkbox sidebar from gamba dataset
                sidebar = sidebar(
                  card(
                    checkboxGroupInput("gambaGroupInput", label = h3("Gambler Select"),
                                       choices = unique(gamba_df$gambler),
                                       selected = character(0)),
                    # Add all and none buttons
                    actionButton("gambaSelectAllButton", label = "All"),
                    actionButton("gambaSelectNoneButton", label = "None"),
                  ),
                ),
                card(
                  # Space for plotting output graph
                  plotOutput("gambaOutputGraph")     
                )
              )
    ),
    nav_panel(title = "Raid Tier Progression", 
              # Sidebar----
              layout_sidebar(
                title = "Render Stats",
                # Generate checkbox sidebar from dataset
                sidebar = sidebar(
                  card(
                    checkboxGroupInput("raidGroupInput", label = h3("Raid Select"),
                                       choices = unique(raidpace_df$raid),
                                       selected = character(0)),
                    # Add all and none buttons
                    actionButton("raidSelectAllButton", label = "All"),
                    actionButton("raidSelectNoneButton", label = "None"),
                  ),
                  # TODO: create average data + chart
                  # Button that toggles average graph
                  #card(
                    #actionButton("raidToggleAverage", label = "Toggle Average")
                  #)
                ),
                card(
                  # Space for plotting output graph
                  plotOutput("raidOutputGraph")     
                )
              )
    )
  )
)