# Server logic----
function(input, output, session) {
  # Sidebar buttons----
  # Raid
  # Select all raid button
  observeEvent(input$raidSelectAllButton, {
    updateCheckboxGroupInput(session, "raidGroupInput",
                             selected = unique(raidpace_df$raid))
  })
  
  # Select none raid button
  observeEvent(input$raidSelectNoneButton, {
    updateCheckboxGroupInput(session, "raidGroupInput",
                             selected = character(0))
  })
  # Gamba
  # Select all gamba button
  observeEvent(input$gambaSelectAllButton, {
    updateCheckboxGroupInput(session, "gambaGroupInput",
                             selected = unique(gamba_df$gambler))
  })
  
  # Select none gamba button
  observeEvent(input$gambaSelectNoneButton, {
    updateCheckboxGroupInput(session, "gambaGroupInput",
                             selected = character(0))
  })
  
  # Filter based on checkboxes----
  # Raid
  raidpace_filtered <- reactive({
    raidpace_df %>% dplyr::filter(raidpace_df$raid %in% input$raidGroupInput)
  })
  # Gamba
  gamba_filtered <- reactive({
    gamba_df %>% dplyr::filter(gamba_df$gambler %in% input$gambaGroupInput)
  }) 
  
  # Output----
  # Raid
  output$raidOutputGraph <- renderPlot({
    ggplot(raidpace_filtered(), aes(x = as.numeric(raid_week),
                                    y = progression,
                                    color = raid)) +
      geom_line(linewidth = 1.5) +
      geom_point(size = 4) +
      theme_light(base_size = 16) + # Make all fonts bigger
      labs(title="Raid Tier Progression Comparison", x="Raid Week", y="Progression") +
      # Custom order the legend
      scale_color_discrete(
        breaks = unique(raidpace_df$raid)) +
      theme(
        plot.title = element_text(size = rel(1.5)), # Make title bigger
        panel.grid.minor = element_blank() # Remove minor gridlines
      ) +
      ylim(0, 1) +
      scale_x_continuous(
        breaks = seq(1, 12, by = 1))
  })
  
  # Gambler
  output$gambaOutputGraph <- renderPlot({
    ggplot(gamba_filtered(), aes(x = date,
                         y = gold,
                         color = gambler)) +
      geom_line(linewidth = 1.5) +
      geom_point(size = 4) +
      geom_hline(yintercept = 0) + # add line at zero
      theme_light(base_size = 16) + # Make all fonts bigger
      labs(title="Gamba Journeys", x="Date", y="Gold") +
      theme(
        plot.title = element_text(size = rel(1.5)), # Make title bigger
        axis.text.x = element_text(angle = 45, hjust = 1), # angle the dates
        panel.grid.minor.x = element_blank() # Remove minor gridlines
      ) + # remove scientific notation and set 100k gridlines
      scale_y_continuous(breaks = seq(-1000000, 1000000, by = 100000),
                         labels = scales::label_comma()) + # add commas to y axis
      scale_x_continuous(breaks = gamba_df$date) # Show every date value
  })  
}