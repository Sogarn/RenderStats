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
  
  # Filter----
  raidpace_filtered <- reactive({
    raidpace_df %>% dplyr::filter(raidpace_df$raid %in% input$raidGroupInput)
  })
  
  # Output----
  output$outputGraph <- renderPlot({
    ggplot(raidpace_filtered(), aes(x = raid_week,
                                    y = progression,
                                    col  = raid, group = id)) +
      geom_line() +
      theme_light() +
      labs(title="Raid progression", x="Raid Week", y="Progression") +
      ylim(0, 1)
  })      
  
}