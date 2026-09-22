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
    nav_panel(title = "Gamba Stats By Patch",
              # Sub tabs
              navset_card_tab(
                # Panels
                nav_panel(
                  title = "12.1",
                  # Sidebar----
                  layout_sidebar(
                    title = "12.1 Gamba Stats",
                    # Generate checkbox sidebar from gamba dataset
                    sidebar = sidebar(
                      card(
                        checkboxGroupInput("gamba_121_GroupInput", label = h3("Gambler Select"),
                                          choices = unique(gamba_121_df$gambler),
                                          selected = character(0)),
                        # Add all and none buttons
                        actionButton("gamba_121_SelectAllButton", label = "All"),
                        actionButton("gamba_121_SelectNoneButton", label = "None"),
                      ),
                    ),
                    card(
                      # Space for plotting output graph
                      plotOutput("gamba_121_OutputGraph")
                    )
                  )
                ),
                nav_panel(
                  title = "12.0",
                  # Sidebar----
                  layout_sidebar(
                    title = "12.0 Gamba Stats",
                    # Generate checkbox sidebar from gamba dataset
                    sidebar = sidebar(
                      card(
                        checkboxGroupInput("gamba_120_GroupInput", label = h3("Gambler Select"),
                                           choices = unique(gamba_120_df$gambler),
                                           selected = character(0)),
                        # Add all and none buttons
                        actionButton("gamba_120_SelectAllButton", label = "All"),
                        actionButton("gamba_120_SelectNoneButton", label = "None"),
                      ),
                    ),
                    card(
                      # Space for plotting output graph
                      plotOutput("gamba_120_OutputGraph")
                    )
                  )
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