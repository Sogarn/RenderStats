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
  # 12.1----
  # Select all gamba button Patch 12.1
  observeEvent(input$gamba121_SelectAllButton, {
    updateCheckboxGroupInput(session, "gamba_121_GroupInput",
                             selected = unique(gamba_121_df))
  })
  # Select none gamba button Patch 12.1
  observeEvent(input$gamba_121_SelectNoneButton, {
    updateCheckboxGroupInput(session, "gamba_121_GroupInput",
                             selected = character(0))
  })
  # 12.0----
  # Select all gamba button Patch 12.0
  observeEvent(input$gamba120_SelectAllButton, {
    updateCheckboxGroupInput(session, "gamba_120_GroupInput",
                             selected = unique(gamba_120_df))
  })
  # Select none gamba button Patch 12.0
  observeEvent(input$gamba_120_SelectNoneButton, {
    updateCheckboxGroupInput(session, "gamba_120_GroupInput",
                             selected = character(0))
  })
  
  # Filter based on checkboxes----
  # Raid
  raidpace_filtered <- reactive({
    raidpace_df %>% dplyr::filter(raidpace_df$raid %in% input$raidGroupInput)
  })
  # Gamba
  gamba_121_filtered <- reactive({
    gamba_121_df %>% dplyr::filter(gamba_121_df$gambler %in% input$gamba_121_GroupInput)
  }) 
  gamba_120_filtered <- reactive({
    gamba_120_df %>% dplyr::filter(gamba_120_df$gambler %in% input$gamba_120_GroupInput)
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
      scale_x_continuous(
        breaks = seq(1, 12, by = 1)) +
      scale_y_continuous(labels = scales::percent,
                         limits = c(0,1))
  })
  
  # Gambler Patch 12.1
  output$gamba_121_OutputGraph <- renderPlot({
    ggplot(gamba_121_filtered(), aes(x = date,
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
      scale_x_continuous(breaks = gamba_121_df$date) # Show every date value
  })
  
  # Gambler Patch 12.0
  output$gamba_120_OutputGraph <- renderPlot({
    ggplot(gamba_120_filtered(), aes(x = date,
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
      scale_x_continuous(breaks = gamba_120_df$date) # Show every date value
  }) 
}