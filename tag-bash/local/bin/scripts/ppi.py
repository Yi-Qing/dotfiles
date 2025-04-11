#!/usr/bin/env python
# -*- coding: UTF-8 -*-

'''
1. 国际视力表标准：人眼视角为万分之三弧度，约1'（角分），也即`1/60`度
2. 对于极小的顶角，等腰三角形的高约等于底边长 / 顶角对应的弧度
3. 弧度计算：角度 * pi / 180

4. dpi与ppi：`dpi * scale / ppi`越接近1，显示效果越符合程序需求
5. 常见操作系统基准dpi为96

6. 最佳的显示器摆放位置为：顶部与眼睛平齐或略低，中心点与顶部和眼睛构成三角形，眼睛对应的角度为15~20度。
参考1：https://www.zhengshili.com/news/?4554.html
参考2：https://www.careeraddict.com/monitor-eye-level
参考3：https://zhuanlan.zhihu.com/p/534442565
参考4：https://zhuanlan.zhihu.com/p/136343236
参考5：https://zhuanlan.zhihu.com/p/40485528

7. 书籍推荐使用5号字体(3.7mm)作为正文，且阅读距离不小于30~35cm，以33cm为准即阅读距离/120等于字体大小
8. 正常来说，1pt = 1/72inch = 25.4/72mm, px = pt*dpi/72 = 25.4*dpi/(72*72)
9. 96 dpi起源：https://learn.microsoft.com/en-us/archive/blogs/fontblog/where-does-96-dpi-come-from-in-windows
    这里的意思就是：微软认为在那边年代，看显示器大概要比看书远1/3的距离，所以把dpi定为96px/inch。
    也就是书籍中标准的72pd/inch放大1/3，如此一来，程序为了让人们看的更清晰，就需要把字体放大到12px，
    这样在实际为72ppi的显示器上，一个文字大小就变成12pt，也即4.23mm，这样就等效正常看书的字体大小。

    现阶段的程序员大多都忘记了这个本质原因，而是认为96dpi就使用12px的字体，这样用户就能看清楚字体了，
    但这只是等效于用户在26~30cm的位置读一本标准书籍。
    所以关于缩放，重点就是通过缩放让12px的字体在当前ppi与阅读距离等效于96dpi + 30~35cm阅读的大小。

    已知：字体等效大小等于(px * 25.4 / dpi) * (读书距离 / 当前距离)，
    这里px固定为12，dpi为96，读书距离为250~300mm，当前距离为x，则字体实际大小应该为x/120，缩放为：
'''

import math

# # 显示常见的系统中，不同ppi对应的scale
# def print_scale(ppi, distance):

# 显示不同视力观看相同ppi屏幕时，需要距离多远可以认为该屏幕是视网膜屏
def print_retina(ppi):
    mm = 25.4 / ppi
    m = mm / 1000
    angle = 3.0 / 10000

    print("\n不同视力超过该距离观看就属于视网膜屏:")
    distance = m / angle
    print(f"1.0/5.0: {distance:.2f}m")
    distance = m / (angle / 0.8)
    print(f"0.8/4.9: {distance:.2f}m")
    distance = m / (angle / 0.6)
    print(f"0.6/4.8: {distance:.2f}m")
    distance = m / (angle / 0.5)
    print(f"0.5/4.7: {distance:.2f}m")
    distance = m / (angle / 0.4)
    print(f"0.4/4.6: {distance:.2f}m")
    distance = m / (angle / 0.3)
    print(f"0.3/4.5: {distance:.2f}m")

# 显示当前屏幕大小下推荐的观看距离，在这个距离以上可以不用移动脑袋即可舒适观看
def get_distance(W, H, diagonal) -> float:
    # 垂直方向角度转换为弧度
    angle = 15 * math.pi / 180  # 理论垂直舒适角度为上下各15度，
    distance_V = (H / 2) / math.tan(angle) / 1000
    print(f"垂直方向视角距离: {distance_V:.2f}m")

    # 水平方向角度转换为弧度
    angle = 25 * math.pi / 180  # 理论水平舒适角度为左右各30度，20度更佳
    distance_H = (W / 2) / math.tan(angle) / 1000
    print(f"水平方向视角距离: {distance_H:.2f}m")

    return max(distance_V, distance_H)

def calc_monitor_parm(px_w, px_h, inch):
    # 计算PPI
    ppi = ((px_w ** 2 + px_h ** 2) ** 0.5) / inch

    # 计算宽高比，然后根据宽高比和对角线长度(inch)计算屏幕实际长与宽
    ratio = px_w / px_h
    diagonal = inch * 25.4 # 对角线长度转换为mm
    H = math.sqrt((diagonal ** 2) / (1 + ratio ** 2))
    W = ratio * H

    rec_distance = get_distance(W, H, diagonal)

    return W, H, ppi , rec_distance

# 获取参数，参数为: 分辨率W，分辨率H，大小(inch)，观看距离(m)
def __main__():
    import sys
    if len(sys.argv) != 4:
        print("Usage: python ppi.py <分辨率W> <分辨率H> <大小(inch)> <观看距离(m)>")
        return
    px_w = int(sys.argv[1])
    px_h = int(sys.argv[2])
    inch = float(sys.argv[3])
    # cur_distance = float(sys.argv[4])

    size_w, size_h, ppi, rec_distance = calc_monitor_parm(px_w, px_h, inch)
    print(f"屏幕宽: {size_w:.2f}mm\
        屏幕高: {size_h:.2f}mm\
        DPI/PPI: {ppi:.2f}\
        推荐最小观看距离: {rec_distance:.2f}m"
        )

    print_retina(ppi)

if __name__ == '__main__':
    __main__()
