
# import markdownify 
import markdownify 


def get_content(path):
    with open(path) as f:
        raw = f.read()
    return raw

html = get_content('./Django_Guide/DjangoGuide.html')
print(html)

# convert html to markdown 
h = markdownify.markdownify(html, heading_style="ATX", code_language="python", heading_style_level=2) 

with open('./Django_Guide/DjangoGuide.md', "w", encoding="utf-8") as f:
    f.write(h)
f.close()

