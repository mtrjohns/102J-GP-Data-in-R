# -----------------------------------------------------------------------------
# Plot Wrapper Script
#
# author: Michael Johns
#
# about: This script allows the use of ggplot function wrappers for code reuse
# Incomplete: Future Iteration
#------------------------------------------------------------------------------

#ggplotBarPercentage <- function(df, inX, inY, infill, inlabel){
#  df <- data.frame( inX = c(practiceID, "Wales"),
#                    PatientsDiagnosedWithCancer =
#                      c(as.numeric(PracticeCancerPercentageTest),
#                      as.numeric(CancerPatientPercentageInWales)))
#  
#  b <- ggplot(data=df, aes(x = inX,
#                           y = 'Patients Diagnosed With Cancer',
#                           fill = infill,
#                           label = paste(inlabel, "%"))) +
#    geom_bar(stat="identity")
#  
#  plot(b + theme(axis.text.y = element_text(angle = 90)) + geom_text(vjust=-0.5))
#}