'''
적용할 폰트들
BlackHanSans-Regular
DoHyeon-Regular
NanumGothicCoding-Bold
NanumGothicCoding-Regular
YeonSung-Regular
KoPub
먼저 extrafont 패키지를 설치해서 폰트 데이터베이스를 만든다.
font_import(pattern= "폰트패밀리 이름")  이렇게 하면 폰트파일을 넣을 수 있다.


'''

library(extrafont)
font_import(pattern = 'NanumGothic')
font_import(pattern = 'KoPub')

loadfonts(device = "win")
windowsFonts()

#위 함수들을 쓰면 폰트가 Rstudio에 적용된걸 알 수 있다.
#폰트는 따로 설치해야한다.

