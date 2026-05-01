# Server logic----
function(input, output, session) {
  # Select all button----
  observeEvent(input$selectAllButton, {
    updateCheckboxGroupInput(session, "raidGroupInput",
                             selected = unique(raidpace_df$raid))
  })
  
  # Select none button----
  observeEvent(input$selectNoneButton, {
    updateCheckboxGroupInput(session, "raidGroupInput",
                             selected = character(0))
  })
  
  # Filter based on checkboxes----
  raidpace_filtered <- reactive({
    raidpace_df %>% dplyr::filter(raidpace_df$raid %in% input$raidGroupInput)
  })
  
  # Output----
  output$outputGraph <- renderPlot({
    ggplot(raidpace_filtered(), aes(x = as.numeric(raid_week),
                                    y = progression,
                                    color = raid)) +
      geom_line(linewidth = 1) +
      geom_point(size = 2) +
      theme_light() +
      labs(title="Raid progression", x="Raid Week", y="Progression") +
      # Custom order the legend
      scale_color_discrete(
        breaks = unique(raidpace_df$raid)) +
      theme(
        plot.title = element_text(size = rel(2.0)) # Make title bigger
      ) +
      ylim(0, 1) +
      scale_x_continuous(
        breaks = seq(1, 12, by = 1))
  })      
  
}