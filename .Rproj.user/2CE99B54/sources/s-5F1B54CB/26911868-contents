slico_avatarize <- function(inp_img, num_spixels = 600){
  init = Image_Segmentation$new()
  spx = init$spixel_segmentation(input_image = inp_img, 
                                 superpixel = num_spixels, 
                                 AP_data = TRUE,
                                 use_median = TRUE, 
                                 sim_wL = 3, 
                                 sim_wA = 10, 
                                 sim_wB = 10,
                                 sim_color_radius = 10, 
                                 verbose = TRUE)
  
  #OpenImageR::imageShow(spx$AP_image_data) # output display  
  return(spx$AP_image_data)
} # func ends


make_gradient <- function(mypic){
  print(mypic, "\n")  # print desc
  cat("Image dimensions are: ", dim(mypic), "\n")  # dimns
  
  dx <- mypic %>% grayscale(.) %>% imgradient(.,"x")
  dy <- mypic %>% grayscale(.) %>% imgradient(.,"y")
  grad.mag <- sqrt(dx^2+dy^2)
  
  op <- par(mfrow=c(2, 2))
  plot(grayscale(mypic), main = "Grayscale img")
  plot(dx, main = "x-axis gradient detection")
  plot(dy, main = "y-axis gradient detection")
  plot(grad.mag, main = "Gradient magnitude")
  par(op)
} # func ends