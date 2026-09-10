# Overview
I tested Microsoft's open source **MarkitDown** at test output: [[markitdown-output]]
an AGPL-3.0 licensed high performance Python library **pymupdf** at [[pdf-text-output]]
IBM's **Docling** package which runs **Table** **OCRs** against
to see which one produces more accurately parsed md results. 
### MarkitDown



### Pymupdf
Apparently, Pymupdf has **OCR** support. By flipping its `use_ocr` parameter to `True` in `pymupdf.to_markdown()`, I allow it to scan for and invoke a Python installed OCR model or package. 
A bundled ***ONNX classifer*** decides per page (probability >= 0.93, or >= 5% garbage characters) to rasterize and OCR before extraction.


However, **Docling's** Rapidocr usage is more accurate than Pymupdf's.





### Winner
**Pymupdf*** seems to detect Headers and parse table structures better than **Markitdown** with no plugins.claude --resume c86c9658-b560-4d69-8e74-70dc9f4bcd21