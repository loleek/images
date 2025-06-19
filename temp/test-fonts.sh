#!/bin/bash
echo "<d83e> 字体功能测试"
echo "创建字体测试文档..."

cat > /tmp/font-test.tex << 'TEXEOF'
\documentclass{article}
\usepackage[utf8]{inputenc}
\usepackage{xeCJK}
\usepackage{amsmath}
\usepackage{geometry}
\geometry{a4paper, margin=1in}

% 设置中文字体
\setCJKmainfont{Noto Sans CJK SC}
\newfontfamily\wenkai{LXGWWenKai-Regular}
\newfontfamily\zcool{ZcoolKuaiLe-Regular}
\newfontfamily\handwrite{Patrick Hand}

\title{字体测试文档}
\author{LaTeX Complete Font Tester}
\date{\today}

\begin{document}

\maketitle

\section{默认中文字体测试}

这是使用 Noto Sans CJK SC (思源黑体) 的中文文本。包含数学公式：$E = mc^2$

\section{特殊字体测试}

{\wenkai 这是使用霞鹜文楷的中文文本，具有手写楷体风格。}

{\zcool 这是使用站酷快乐体的中文文本，具有现代设计感。}

\section{英文手写体测试}

{\handwrite This is English text using Patrick Hand font, which has a handwriting style.}

\section{数学公式测试}

二次方程求解公式：
\begin{equation}
x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}
\end{equation}

矩阵示例：
\begin{equation}
\begin{pmatrix}
1 & 2 & 3 \\
4 & 5 & 6 \\
7 & 8 & 9
\end{pmatrix}
\end{equation}

\end{document}
TEXEOF

echo "编译测试文档..."
cd /tmp
xelatex -interaction=nonstopmode font-test.tex > /dev/null 2>&1

if [ -f font-test.pdf ]; then
    echo "✅ 字体测试成功！生成了 font-test.pdf"
    echo "<d83d> PDF页数: $(pdfinfo font-test.pdf | grep Pages | awk '{print $2}')"
else
    echo "❌ 字体测试失败，请检查字体安装"
fi

rm -f font-test.* 2>/dev/null || true
echo "<d83e> 字体测试完成"
