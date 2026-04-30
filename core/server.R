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
  output$outputGraph <- renderTable({
    raidpace_filtered()
  })
  
}

# Saving this for later
# # Update what data to plot by row----
# raidpace_filtered <- reactive({
#   # Pick rows we need
#   raidpace_df[input$raidGroupInput, , drop = FALSE] %>%
#     # Pivot
#     pivot_longer(
#       cols = everything,
#       names_to = "Raid_Week",
#       values_to = "Progression"
#     )
# })
# 
# # Output graph----
# output$outputGraph <- 
#   renderPlot({
#     ggplot(raidpace_filtered(), aes(x = Raid_Week, y = Progression, col = raid)) +
#       geom_line() +
#       theme_minimal() +
#       labs(title="Raid progression", x="Raid_Week", y="Progression")
#   })      
# }