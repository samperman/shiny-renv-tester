library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "Package Installation Verification",
  sidebar = sidebar(
    h4("Installed Packages"),
    p("This app demonstrates that grithub, S4Vectors and magick are properly installed."),
    actionButton("test_grithub", "Test grithub from github", class = "btn-primary mb-2"),
    actionButton("test_bioc", "Test S4Vectors from Bioconductor", class = "btn-primary mb-2"),
    actionButton("test_opensci", "Test opensci repo", class = "btn-primary mb-2")
  ),
  card(
    card_header("grithub Test Results"),
    verbatimTextOutput("grithub_results")
  ),
  card(
    card_header("Bioconductor Test Results"),
    verbatimTextOutput("bioc_results")
  ),
  card(
    card_header("opensci Test Results"),
    verbatimTextOutput("opensci_results")
  )
)

server <- function(input, output, session) {
  
  # Test grithub functionality
  observeEvent(input$test_grithub, {
    output$grithub_results <- renderText({
      tryCatch({
        paste0("grithub package loaded successfully!\n", grithub::hello())
      }, error = function(e) {
        paste("Error testing grithub:", e$message)
      })
    })
  })
  
  # Test S4Vectors functionality
  observeEvent(input$test_bioc, {
    output$bioc_results <- renderText({
      tryCatch({
        # Create a simple S4Vector
        vec <- c(1, 2, 3, 4, 5)
        s4_vec <- S4Vectors::Rle(vec)
        
        paste0(
          "S4Vectors package loaded successfully!\n",
          "Package version: ", packageVersion("S4Vectors"), "\n",
          "Created Rle object: ", toString(as.vector(s4_vec)), "\n",
          "Length: ", length(s4_vec), "\n",
          "Class: ", class(s4_vec)
        )
      }, error = function(e) {
        paste("Error testing S4Vectors:", e$message)
      })
    })
  })
  
  # Test magick functionality
  observeEvent(input$test_opensci, {
    output$opensci_results <- renderText({
      tryCatch({
        library(piggyback)
        paste0(
          "piggyback package loaded successfully!\n",
          "Package version: ", packageVersion("piggyback"), "\n"
        )
      }, error = function(e) {
        paste("Error testing opensci:", e$message)
      })
    })
  })
}

shinyApp(ui = ui, server = server)
