-- This gives us plain fancy break in LaTeX.
local hashrule = [[<w:p>
  <w:pPr>
    <w:pStyle w:val="HorizontalRule"/>
      <w:ind w:firstLine="0"/>
      <w:jc w:val="center"/>
  </w:pPr>
  <w:r>
    <w:t>#</w:t>
  </w:r>
</w:p>]]
function HorizontalRule (elem)
    -- print("FORMAT: " .. FORMAT)
    if FORMAT == 'latex' then
      return pandoc.RawBlock('latex', '\\pfbreak')
    end
    if FORMAT == 'docx' then
      return pandoc.RawBlock('openxml', hashrule)
    end
end

-- counts words in a document
words = 0
wordcount = {
  Str = function(el)
    -- we don't count a word if it's entirely punctuation:
    if el.text:match("%P") then
        words = words + 1
    end
  end,

  Code = function(el)
    _,n = el.text:gsub("%S+","")
    words = words + n
  end,

  CodeBlock = function(el)
    _,n = el.text:gsub("%S+","")
    words = words + n
  end
}
function Pandoc(el)
  -- skip metadata, just count body:
  pandoc.walk_block(pandoc.Div(el.blocks), wordcount)
  print(words .. " words in body")
  -- os.exit(0)
end
