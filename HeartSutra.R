library(stringr)
library(jiebaR)
library(wordcloud)
library(tm)
library(tmcn)
library(dplyr)

setwd("C:/Peter/Dropbox/Project/TextMining/HeartSutra")

hs <- "觀自在菩薩行深般若波羅蜜多時照見五蘊皆空度一切苦厄舍利子色不異空空不異色色即是空空即是色受想行識亦復如是舍利子是諸法空相不生不滅不垢不淨不增不減是故空中無色無受想行識無眼耳鼻舌身意無色聲香味觸法無眼界乃至無意識界無無明亦無無明盡乃至無老死亦無老死盡無苦集滅道無智亦無得以無所得故菩提薩埵依般若波羅蜜多故心無罣礙無罣礙故無有恐怖遠離顛倒夢想究竟涅槃三世諸佛依般若波羅蜜多故得阿耨多羅三藐三菩提故知般若波羅蜜多是大神咒是大明咒是無上咒是無等等咒能除一切苦真實不虛故說般若波羅蜜多咒即說咒曰揭諦揭諦波羅揭諦波羅僧揭諦菩提薩婆訶"

# cutter
cutter <- worker(bylines = F)
c1 <- cutter[hs]

# add new complete words
new_words <- c("色聲香味觸法", "般若波羅蜜多")
for (i in 1:length(new_words)) {
  new_user_word(cutter, new_words[i])
}
writeLines(new_words, "new_words.txt")

# set new STOP words
stop_words <- c("是", "如")
writeLines(stop_words, "stop_words.txt")

# re-cut
cutter <- worker(
  user = "new_words.txt", 
  stop_word = "stop_words.txt", 
  bylines = FALSE)
c2 <- cutter[hs]

# frequency
txt_freq <- freq(c2)
txt_freq <- arrange(txt_freq, desc(freq))

# word-cloud
par(family=("Microsoft YaHei"))
wordcloud(txt_freq$char, 
          txt_freq$freq, 
          min.freq = 1, 
          random.order = F, 
          ordered.colors = T, 
          colors = rainbow(nrow(txt_freq)))

# end