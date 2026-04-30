# Entire page----
fluidPage(
  # Sidebar----
  page_sidebar(
    title = "Render Stats",
    # Generate checkbox sidebar from dataset
    sidebar = sidebar(
      card(
        checkboxGroupInput("raidGroupInput", label = h3("Raid Select"),
                           choices = unique(raidpace_df$raid),
                           selected = unique(raidpace_df$raid)),
        # Add all and none buttons
        actionButton("selectAllButton", label = "All"),
        actionButton("selectNoneButton", label = "None")      
      )
    ),
    card(
      # Space for plotting output graph
      plotOutput("outputGraph")     
    )
  )
)