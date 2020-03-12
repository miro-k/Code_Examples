# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
# ui.R
#
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


HEADER <- dashboardHeader(
   dropdownMenu(
      type = "messages",
      messageItem(
         from = "Lucy",
         message = "You can view the International Space Station!",
         href = "https://spotthestation.nasa.gov/sightings/"
      ),
      # Add a second messageItem()
      messageItem(
         from = "Lucy",
         message = "Learn more about the International Space Station",
         href = "https://spotthestation.nasa.gov/faq.cfm"
      )
   ),
   dropdownMenu(
      type = "notifications",
      notificationItem(
         text = "The international Space Station is overhead!"
      )
   ),
   dropdownMenu(
      type = "tasks",
      taskItem(
         text = "Mission Learn Shiny Dashboard",
         value = 10
      )
   )
)


SIDEBAR <- dashboardSidebar(
   sidebarMenu(
      menuItem(text = "Dashboard", tabName = "dashboard"),
      menuItem(text = "Inputs", tabName = "inputs")
   )
)


BODY <- dashboardBody(
   tabItems(
      tabItem(
         tabName = "dashboard",
         tabBox(
            title = "International Space Station Fun Facts",
            tabPanel("Fun Fact 1", "XXX"),
            tabPanel("Fun Fact 2", "YYY")
         )
      ),
      tabItem(
         tabName = "inputs"
      )
   )
)


UI <- dashboardPage(header = HEADER, sidebar = SIDEBAR, body = BODY)


