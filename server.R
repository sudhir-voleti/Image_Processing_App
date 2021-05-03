
server <- shinyServer(function(input, output) {
  
  output$text <- renderText({
    download.file(input$url,"1.jpeg",mode = "wb")
    img <- readImage("1.jpeg")
    writeImage(img, "img.jpeg", quality=100)
    "Image:"
  })
  
  
  file_name <- reactive({
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    return (stringi::stri_extract_first(str = inFile$name, regex = ".*(?=\\.)"))
  })
  
  
  
  output$img <- renderImage({
    
    Rb <- input$Rb
    Rc <- input$Rc
    Rg <- input$Rg
    
    Gb <- input$Gb
    Gc <- input$Gc
    Gg <- input$Gg
    
    Bb <- input$Bb
    Bc <- input$Bc
    Bg <- input$Bg
    
    
    if (is.null(input$file)) { 
    oi <- readImage("img.jpeg")
    }else{
    oi <- readImage(input$file$datapath)
    }
    oi[,,1] <- ((Rc/100)*oi[,,1] + (Rb/100))^(Rg)
    oi[,,2] <- ((Gc/100)*oi[,,2] + (Gb/100))^(Gg)
    oi[,,3] <- ((Bc/100)*oi[,,3] + (Bb/100))^(Bg)
    writeImage(oi, "img2.jpeg", quality=100)
    
    if (is.null(input$Save)){
      oi <- oi
    }
    else {
      writeImage(oi, "img.jpeg", quality=100)
    }
    filename <- normalizePath(file.path('./',paste0('img2','.jpeg')))
    
    list(src = filename)
    
    
  }, deleteFile = FALSE)
  
  
  output$img2 <- renderImage({
    
    
    if (is.null(input$file)) { 
      oi2 <- readImage("img.jpeg")
    }else{
      oi2 <- readImage(input$file$datapath)
    }
    
    oi2 <- rotate(oi2,input$rot)
    if (is.null(input$flip)){
      oi2 <- oi2
    }
    else if (input$flip ==1){
      oi2 <- flip(oi2)
    }
    else if (input$flip ==2){
      oi2[,,1] <- flip(oi2[,,1])
    }
    else if (input$flip ==3){
      oi2[,,2] <- flip(oi2[,,2])
    }
    else if (input$flip ==4){
      oi2[,,3] <- flip(oi2[,,3])
    }
    
    if (is.null(input$flop)){
      oi2 <- oi2
    }
    else if (input$flop ==1){
      oi2 <- flop(oi2)
    }
    else if (input$flop ==2){
      oi2[,,1] <- flop(oi2[,,1])
    }
    else if (input$flop ==3){
      oi2[,,2] <- flop(oi2[,,2])
    }
    else if (input$flop ==4){
      oi2[,,3] <- flop(oi2[,,3])
    }
    
    if (is.null(input$channel)){
      oi2 <- oi2
    }
    else if (input$channel == 1){
      oi2 <- readImage("img.jpeg")
    }
    else if (input$channel == 2){
      oi2 <- channel(oi2,"grey")
    }
    else if (input$channel == 3){
      oi2 <- channel(oi2,"r")
    }
    else if (input$channel == 4){
      oi2 <- channel(oi2,"g")
    }
    else if (input$channel == 5){
      oi2 <- channel(oi2,"b")
    }
    if (is.null(input$Save)){
      oi2 <- oi2
    }
    else {
      writeImage(oi2, "img.jpeg", quality=100)
    }
    oi2 = translate(oi2, c(input$transx, input$transy))
    writeImage(oi2, "img2.jpeg", quality=100)
    
    filename <- normalizePath(file.path('./',paste0('img2','.jpeg')))
    list(src = filename)
  }, deleteFile = FALSE)
  
  output$img3 <- renderImage({
    if (is.null(input$file)) { 
      oi2 <- readImage("img.jpeg")
    }else{
      oi2 <- readImage(input$file$datapath)
    }
    
    
   
    if (input$lps>1){
      if (input$lps %% 2 == 0 ){
        lps <- input$lps + 1
      }
      else {
        lps <- input$lps
      }
    }
    else {
      lps <- input$lps
    }
    
    flo <- makeBrush(lps, shape="disc", step=FALSE)^2
    flo <- flo/sum(flo)
    fhi <- matrix(1, nc=3, nr=3)
    fhi[2,2] = -input$hps
    
    if (is.null(input$filt)){
      oi2 <- oi2
    }
    else if (input$filt == 1){
      oi2 <- filter2(oi2, flo)
    }
    else if (input$filt == 2){
      oi2 <- filter2(oi2, fhi)
    }
    
    if (is.null(input$Save1)){
      oi2 <- oi2
    }
    else {
    writeImage(oi2, "img.jpeg", quality=100)
    }
    writeImage(oi2, "img2.jpeg", quality=100)
    
    filename <- normalizePath(file.path('./',paste0('img2','.jpeg')))
    list(src = filename)
  }, deleteFile = FALSE)
  
  output$img4 <- renderImage({
    
    if (is.null(input$file)) { 
      oi2 <- readImage("img.jpeg")
    }else{
      oi2 <- readImage(input$file$datapath)
    }

    if (input$mm>1){
      if (input$mm %% 2 == 0 ){
        mm <- input$mm + 1
      }
      else {
        mm <- input$mm
      }
    }
    else {
      mm <- input$mm
    }
    
    kern <- makeBrush(mm, shape="diamond")^2
    
    if (is.null(input$morph)){
      oi2 <- oi2
    }
    else if (input$morph == 1){
      oi2 <-  EBImage::erode(oi2, kern)
    }
    else if (input$morph == 2){
      oi2 <- EBImage::dilate(oi2, kern)
    }
    
    if (is.null(input$Save1)){
      oi2 <- oi2
    }
    else {
      writeImage(oi2, "img.jpeg", quality=100)
    }
    writeImage(oi2, "img2.jpeg", quality=100)
    
    filename <- normalizePath(file.path('./',paste0('img2','.jpeg')))
    list(src = filename)
  }, deleteFile = FALSE)
  
  
  output$img5 <- renderImage({
    if (is.null(input$file)) { 
      oi2 <- readImage("img.jpeg")
    }else{
      oi2 <- readImage(input$file$datapath)
    }
    
    temp <- slico_avatarize(oi2, num_spixels = input$pix) # 9.3s  
    writeImage(temp, "avt.jpeg", quality=100)
    filename <- normalizePath(file.path('./',paste0('avt','.jpeg')))
    list(src=filename)
  },deleteFile = FALSE)
  
  output$img_6 <- renderPlot({
    if (is.null(input$file)) { 
      oi2 <- load.image("img.jpeg")
    }else{
      oi2 <- load.image(input$file$datapath)
    }
    make_gradient(oi2)
  }
    
  )
  

output$dn_4 <- output$dn_3 <-output$dn_2 <- output$dn_1 <- downloadHandler(
      filename = function(){
        if (is.null(input$file)) { 
          paste("modified_img",".jpg")
        }else{
          paste(file_name())
        }
      },
      contentType = "image/jpeg",
      content = function(file){
        
        if (is.null(input$Save0)){
          file.copy("img.jpeg",file,overwrite = T)
        }
        else {
          file.copy("img2.jpeg",file,overwrite = T )
        }
        
      }
  )
  
output$dn_5 <- downloadHandler(
  filename = function(){
    if (is.null(input$file)) { 
      paste("avatar_img",".jpg")
    }else{
      paste(file_name())
    }
  },
  contentType = "image/jpeg",
  content = function(file){
    
    if (is.null(input$Save0)){
      file.copy("avt.jpeg",file,overwrite = T)
    }
    else {
      file.copy("avt.jpeg",file,overwrite = T)
    }
    
  }
)

  
})