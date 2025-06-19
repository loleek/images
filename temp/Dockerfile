# 完整版 LaTeX 批量转换器 - 包含所有字体和中文支持
# 使用国内镜像源的 Ubuntu 22.04 以加速下载
FROM registry.cn-hangzhou.aliyuncs.com/acs/ubuntu:22.04

# 设置环境变量避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 更换为国内软件源以加速安装
RUN sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list && \
    sed -i 's/security.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list

# ==================== 第一阶段：安装基础 LaTeX 环境和工具 ====================
RUN ls -al /etc/apt/apt.conf.d/
RUN rm -f /etc/apt/apt.conf.d/docker-clean
RUN apt-get update && apt-get install -y \
    # 基础 LaTeX 包
    texlive-latex-base \
    texlive-latex-recommended \
    texlive-latex-extra \
    texlive-fonts-recommended \
    texlive-fonts-extra \
    texlive-science \
    texlive-font-utils \
    texlive-plain-generic \
    # XeLaTeX 和 LuaLaTeX 支持
    texlive-xetex \
    texlive-luatex \
    # 中文 LaTeX 支持
    texlive-lang-chinese \
    latex-cjk-chinese \
    latex-cjk-chinese-arphic-bkai00mp \
    latex-cjk-chinese-arphic-bsmi00lp \
    latex-cjk-chinese-arphic-gbsn00lp \
    latex-cjk-chinese-arphic-gkai00mp \
    # 图片转换工具
    imagemagick \
    ghostscript \
    poppler-utils \
    # 下载和字体工具
    wget \
    curl \
    unzip \
    git \
    fontconfig

# 配置 ImageMagick 安全策略，允许处理 PDF
RUN sed -i 's/rights="none" pattern="PDF"/rights="read|write" pattern="PDF"/g' /etc/ImageMagick-6/policy.xml

# ==================== 第二阶段：安装中文字体 ====================
RUN apt-get update && apt-get install -y \
    # 基础中文字体
    fonts-noto-cjk \
    fonts-noto-cjk-extra \
    fonts-noto-extra \
    fonts-wqy-microhei \
    fonts-wqy-zenhei \
    fonts-arphic-ukai \
    fonts-arphic-uming \
    fonts-arphic-bkai00mp \
    fonts-arphic-gkai00mp

# ==================== 第三阶段：创建字体目录结构 ====================
RUN mkdir -p /usr/share/fonts/truetype/custom
RUN mkdir -p /usr/share/fonts/truetype/google-fonts
RUN mkdir -p /usr/share/fonts/truetype/handwriting
RUN mkdir -p /usr/share/fonts/truetype/chinese-handwriting
RUN mkdir -p /usr/share/fonts/truetype/zcool
RUN mkdir -p /usr/share/fonts/truetype/alibaba
RUN mkdir -p /usr/share/fonts/truetype/creative
RUN mkdir -p /usr/share/fonts/truetype/enhanced

# 设置临时工作目录
WORKDIR /tmp/fonts

# ==================== 第四阶段：下载 Google Fonts 手写体字体 ====================
RUN echo "下载 Google Fonts 手写体字体..." && \
    cd /usr/share/fonts/truetype/google-fonts && \
    # Patrick Hand - 手写体
    (wget -O PatrickHand-Regular.ttf "https://github.com/google/fonts/raw/main/ofl/patrickhand/PatrickHand-Regular.ttf" || echo "Patrick Hand 下载失败") && \
    # Homemade Apple - 手工风格
    (wget -O HomemadeApple-Regular.ttf "https://github.com/google/fonts/raw/main/apache/homemadeapple/HomemadeApple-Regular.ttf" || echo "Homemade Apple 下载失败") && \
    # Dancing Script - 舞动手写体
    (wget -O DancingScript-Regular.ttf "https://github.com/google/fonts/raw/main/ofl/dancingscript/DancingScript%5Bwght%5D.ttf" || echo "Dancing Script 下载失败") && \
    # Shadows Into Light - 阴影体 (修复URL)
    (wget -O ShadowsIntoLight-Regular.ttf "https://github.com/google/fonts/raw/main/ofl/shadowsintolight/ShadowsIntoLight-Regular.ttf" || \
     wget -O ShadowsIntoLight-Regular.ttf "https://fonts.gstatic.com/s/shadowsintolight/v19/UqyNK9UOIntux_czAvDQx_ZcHqZXBNQDcsr4xzSMYA.ttf" || \
     echo "Shadows Into Light 下载失败") && \
    # Amatic SC - 手绘风格 (修复URL)
    (wget -O AmaticSC-Regular.ttf "https://github.com/google/fonts/raw/main/ofl/amaticsc/AmaticSC-Regular.ttf" || \
     wget -O AmaticSC-Regular.ttf "https://fonts.gstatic.com/s/amaticsc/v26/TUZyzwprpvBS1izr_vOMscDJvBs.ttf" || \
     echo "Amatic SC Regular 下载失败") && \
    (wget -O AmaticSC-Bold.ttf "https://github.com/google/fonts/raw/main/ofl/amaticsc/AmaticSC-Bold.ttf" || \
     wget -O AmaticSC-Bold.ttf "https://fonts.gstatic.com/s/amaticsc/v26/TUZ3zwprpvBS1izr_vO0De6ecZQf-A.ttf" || \
     echo "Amatic SC Bold 下载失败") && \
    # Handlee - 自然手写体
    (wget -O Handlee-Regular.ttf "https://github.com/google/fonts/raw/main/ofl/handlee/Handlee-Regular.ttf" || echo "Handlee 下载失败") && \
    # Kalam - 现代手写体
    (wget -O Kalam-Regular.ttf "https://github.com/google/fonts/raw/main/ofl/kalam/Kalam-Regular.ttf" || echo "Kalam 下载失败") && \
    # Caveat - 随意风格
    (wget -O Caveat-Regular.ttf "https://github.com/google/fonts/raw/main/ofl/caveat/Caveat%5Bwght%5D.ttf" || echo "Caveat 下载失败") && \
    # Architects Daughter - 建筑师女儿体
    (wget -O ArchitectsDaughter-Regular.ttf "https://github.com/google/fonts/raw/main/ofl/architectsdaughter/ArchitectsDaughter-Regular.ttf" || echo "Architects Daughter 下载失败") && \
    # Indie Flower - 独立花体
    (wget -O IndieFlower-Regular.ttf "https://github.com/google/fonts/raw/main/ofl/indieflower/IndieFlower-Regular.ttf" || echo "Indie Flower 下载失败") && \
    # Nothing You Could Do - 随性体
    (wget -O NothingYouCouldDo-Regular.ttf "https://github.com/google/fonts/raw/main/ofl/nothingyoucoulddo/NothingYouCouldDo-Regular.ttf" || echo "Nothing You Could Do 下载失败") && \
    echo "Google Fonts 字体下载完成"

# ==================== 第五阶段：下载站酷字体系列 ====================
RUN echo "下载站酷字体系列..." && \
    cd /usr/share/fonts/truetype/zcool && \
    # 站酷快乐体
    wget -O ZcoolKuaiLe-Regular.ttf "https://fonts.gstatic.com/s/zcoolkuaile/v11/tssQApxBaigK_hnnc1qPcEU3dSuLDU-4Gb1s.ttf" && \
    # 站酷小微体
    wget -O ZcoolXiaoWei-Regular.ttf "https://fonts.gstatic.com/s/zcoolxiaowei/v10/i7dMIFByZjaNAMxtZcnfAy5H2S6S7gTtJLfE.ttf" && \
    # 尝试下载站酷青科黄油体
    git clone --depth 1 https://github.com/googlefonts/zcool-qingke-huangyou.git qingke 2>/dev/null && \
    if [ -d qingke ]; then \
        find qingke -name "*.ttf" -o -name "*.otf" | xargs -I {} cp {} .; \
        rm -rf qingke; \
    fi || echo "站酷青科黄油体下载失败，跳过"

# ==================== 第六阶段：下载阿里巴巴普惠体 ====================
RUN echo "下载阿里巴巴普惠体..." && \
    cd /usr/share/fonts/truetype/alibaba && \
    # 从阿里巴巴官方源下载
    wget -O AlibabaSans.zip "https://puhuiti.oss-cn-hangzhou.aliyuncs.com/AlibabaSans.zip" && \
    if [ -f AlibabaSans.zip ]; then \
        unzip -q AlibabaSans.zip; \
        rm -f AlibabaSans.zip; \
    fi || \
    # 备用下载源
    wget -O AlibabaSans-Regular.ttf "https://github.com/AlibabaPuHuiTi/AlibabaPuHuiTi/releases/download/v3.0.0/AlibabaSans-Regular.ttf" || \
    echo "阿里巴巴普惠体下载失败，跳过"

# ==================== 第七阶段：下载开源中文创意字体 ====================
RUN echo "下载开源中文创意字体..." && \
    cd /usr/share/fonts/truetype/creative && \
    # 得意黑（现代创意字体）
    wget -O SmileySans-Oblique.ttf "https://github.com/atelier-anchor/smiley-sans/releases/download/v2.0.1/SmileySans-Oblique.ttf" && \
    # 霞鹜文楷（手写楷体风格）
    wget -O LXGWWenKai-Regular.ttf "https://github.com/lxgw/LxgwWenKai/releases/download/v1.330/LXGWWenKai-Regular.ttf" && \
    wget -O LXGWWenKai-Bold.ttf "https://github.com/lxgw/LxgwWenKai/releases/download/v1.330/LXGWWenKai-Bold.ttf" && \
    # 霞鹜新晰黑（现代黑体）
    wget -O LXGWNewClear-Regular.ttf "https://github.com/lxgw/LxgwNewClear/releases/download/v1.021/LXGWNewClear-Regular.ttf" || \
    echo "部分创意字体下载失败，继续"

# ==================== 第八阶段：下载更多手写风格字体 ====================
RUN echo "下载更多手写风格字体..." && \
    cd /usr/share/fonts/truetype/handwriting && \
    # 江西拙楷（手写楷体）
    wget -O JiangxiZhuoKai-Regular.ttf "https://github.com/TrionesType/zhuoque/releases/download/v1.002/TrionesZhuoKai-Regular.ttf" && \
    # 仓耳今楷（现代楷体）
    wget -O TsangerJinKai-Regular.ttf "https://github.com/tsanger/Tsanger/releases/download/v2.042/TsangerJinKai03-W03.ttf" && \
    # 优设标题黑（创意黑体）
    wget -O YousheBiaotihei-Regular.ttf "https://github.com/atelier-anchor/smiley-sans/releases/download/v2.0.1/SmileySans-Oblique.ttf" || \
    echo "部分手写字体下载失败，继续"

# ==================== 第九阶段：创建字体回退链接和别名 ====================
RUN echo "创建字体回退机制和别名..." && \
    # 创建字体别名配置文件
    mkdir -p /etc/fonts/conf.d
COPY 99-font-aliases.conf /etc/fonts/conf.d/99-font-aliases.conf

# 创建字体回退链接
RUN echo "创建字体回退链接..." && \
    # 如果某些字体下载失败，使用已有字体作为回退
    cd /usr/share/fonts/truetype/zcool && \
    if [ ! -f ZcoolKuaiLe-Regular.ttf ] && [ -f /usr/share/fonts/truetype/creative/LXGWWenKai-Regular.ttf ]; then \
        ln -sf /usr/share/fonts/truetype/creative/LXGWWenKai-Regular.ttf ZcoolKuaiLe-Regular.ttf; \
    fi && \
    if [ ! -f ZcoolXiaoWei-Regular.ttf ] && [ -f /usr/share/fonts/opentype/noto/NotoSansCJK-Regular.ttc ]; then \
        ln -sf /usr/share/fonts/opentype/noto/NotoSansCJK-Regular.ttc ZcoolXiaoWei-Regular.ttf; \
    fi && \
    # 为缺失的Google Fonts创建回退链接
    cd /usr/share/fonts/truetype/google-fonts && \
    if [ ! -f ShadowsIntoLight-Regular.ttf ] && [ -f PatrickHand-Regular.ttf ]; then \
        ln -sf PatrickHand-Regular.ttf ShadowsIntoLight-Regular.ttf; \
    fi && \
    if [ ! -f AmaticSC-Regular.ttf ] && [ -f PatrickHand-Regular.ttf ]; then \
        ln -sf PatrickHand-Regular.ttf AmaticSC-Regular.ttf; \
    fi

# ==================== 第十阶段：设置字体权限和更新缓存 ====================
RUN echo "设置字体权限和更新缓存..." && \
    # 设置所有字体文件的正确权限
    find /usr/share/fonts/truetype -type f \( -name "*.ttf" -o -name "*.otf" \) -exec chmod 644 {} \; 2>/dev/null || true && \
    # 更新字体缓存
    fc-cache -fv

# ==================== 第十一阶段：创建工作目录和脚本 ====================
WORKDIR /workspace

# 复制转换脚本
COPY convert_fixed.sh /usr/local/bin/convert.sh
COPY batch_convert.sh /usr/local/bin/batch_convert.sh
COPY batch_convert_parallel.sh /usr/local/bin/batch_convert_parallel.sh
RUN chmod +x /usr/local/bin/convert.sh /usr/local/bin/batch_convert.sh /usr/local/bin/batch_convert_parallel.sh

# ==================== 第十二阶段：创建字体管理脚本 ====================
COPY list-all-fonts.sh /usr/local/bin/list-all-fonts.sh
RUN chmod +x /usr/local/bin/list-all-fonts.sh

# ==================== 第十三阶段：创建字体测试脚本 ====================
COPY test-fonts.sh /usr/local/bin/test-fonts.sh
RUN chmod +x /usr/local/bin/test-fonts.sh

# ==================== 第十四阶段：清理和最终设置 ====================
# 清理临时文件
RUN rm -rf /tmp/fonts

# 创建字体映射文档
COPY FONT_MAPPING.md /usr/share/fonts/FONT_MAPPING.md

# 显示安装完成信息
RUN echo "��� LaTeX 完整版构建完成！" && \
    echo "��� 安装的字体总数: $(fc-list | wc -l)" && \
    echo "��� 运行 'list-all-fonts.sh' 查看详细字体信息" && \
    echo "��� 运行 'test-fonts.sh' 测试字体功能" && \
    echo "��� 查看 /usr/share/fonts/FONT_MAPPING.md 了解字体映射"

# 设置入口点为批量转换脚本
ENTRYPOINT ["/usr/local/bin/batch_convert.sh"]
