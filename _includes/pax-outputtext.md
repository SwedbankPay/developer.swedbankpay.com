{:.code-view-header}
OutputText class used when calling RequestToPrint to use the A920pro printer.

```c#
namespace SwpTrmLib.Nexo {
    public class OutputText
    {
        public enum CharacterHeights { Normal, SingleHeight, DoubleHeight, HalfHeight };
        public enum CharacterWidths { Normal, SingleWidth, DoubleWidth };
        public enum Alignments { Left, Right, Centred, Justified };
        public enum Colors { Black, White};

        public CharacterHeights Height { get; set; } = CharacterHeights.Normal;
        public CharacterWidths Width { get; set; } = CharacterWidths.Normal;
        public Alignments Alignment { get; set; } = Alignments.Left;
        public Colors Color { get; set; } = Colors.Black;

        public int StartRow { get; set; } = 0;
        public string Content { get; set; } = string.Empty;
        public XElement XML();
    }
}
```
