library(targets)
library(mypackage)
library(ggplot2)
library(tarchetypes)
# This is an example _targets.R file. Every
# {targets} pipeline needs one.
# Use tar_script() to create _targets.R and tar_edit()
# to open it again for editing.
# Then, run tar_make() to run the pipeline
# and tar_read(summary) to view the results.

# Define custom functions and other global objects.
# This is where you write source(\"R/functions.R\")
# if you keep your functions in external scripts.
summ <- function(dataset) {
  summarize(dataset, mean_x = mean(x))
}

# Set target-specific options such as packages.
tar_option_set(packages = "dplyr")

# End this file with a list of target objects.
list(
  tar_target(data, data.frame(x = sample.int(100), y = sample.int(100))),
  tar_target(summary, summ(data)) # Call your custom functions as needed.
)

# On configure targets pour référencer le bon fichier de pipeline
tar_config_set(store = "posts/post-with-code/_targets",
               script = "posts/post-with-code/_targets.R")

# Set target-specific options such as packages.

triangle <- rbind(c(0,0), c(1,0), c(0.5, sqrt(3)/2))

list(
  tar_target("Iteration_1", divide_triangle(triangle)),
  tar_target("plot1", plot_triangles(Iteration_1)),
  tar_target("heron1", heron2(Iteration_1)),
  tar_target("Iteration_2", divide_list_triangle(Iteration_1)),
  tar_target("plot2", plot_triangles(Iteration_2)),
  tar_target("heron2", heron2(Iteration_2)),
  tar_target("Iteration_3", divide_list_triangle(Iteration_2)),
  tar_target("plot3", plot_triangles(Iteration_3)),
  tar_target("heron3", heron2(Iteration_3)),
  tar_target("Iteration_4", divide_list_triangle(Iteration_3)),
  tar_target("plot4", plot_triangles(Iteration_4)),
  tar_target("heron4", heron2(Iteration_4)),
  tar_target("Render_post", tar_quarto(post.qmd))
)





