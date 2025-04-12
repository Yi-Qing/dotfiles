#!/usr/bin/env python
# -*- coding: UTF-8 -*-

'''
 1. 国际上认为人眼最小视角为万分之三弧度，约1'（角分），也即`1/60`度
 2. 对于极小的顶角，等腰三角形的高约等于底边长 / 顶角对应的弧度
 3. 弧度计算：角度 * pi / 180
 4. dpi与ppi：`dpi * scale / ppi`越接近1，显示效果越符合程序需求
 5. 常见操作系统基准dpi为96
 6. 最佳的显示器摆放位置为：顶部与眼睛平齐或略低，中心点与顶部和眼睛构成三角形，眼睛对应的角度为15~20度。
 7. 书籍推荐使用5号字体(10.5pt/3.7mm)作为正文，且阅读距离不小于30~35cm
 8. 正常来说，1pt = 1/72inch = 25.4/72mm, px = pt*dpi/72 = 25.4*dpi/(72*72)
 9. 关于缩放，重点就是通过缩放让对应pt的字体在当前ppi与阅读距离等效于72dpi + 30~35cm阅读的大小。
10. 对于pt的缩放：(当前距离 / 阅读距离) * 72 / 96。
11. 对于px，老网站都是按照12px作为标准，现在才开始推荐使用16px，现行的大部分是14px。
12. px和pt之间的关系为：px = pt * dpi / 72

96dpi起源：https://learn.microsoft.com/en-us/archive/blogs/fontblog/where-does-96-dpi-come-from-in-windows
这里的意思就是：微软认为在那个年代，看显示器大概要比看书远1/3的距离，所以把dpi定为96px/inch。
也就是书籍中标准的72pd/inch放大1/3，如此一来，为了让人们看的更清晰，程序就需要把字体放大到12px，
这样在实际为72ppi的显示器上，一个文字大小就变成12pt，也即4.23mm，就等效于在看书距离上书的字体大小。
'''

import math

inch_2_mm = 25.4

# 显示当前离屏距离下推荐的缩放值
def print_scale(distance):
    read_dist = 37  # 理论上是33，不过我爱护眼睛有问题吗
    scale = (distance / read_dist) * 72 / 96
    print(f"推荐使用缩放：{scale:.6f}")

def print_px_scale(ppi):
    print("\n正文使用如下磅值时推荐的对应px值:")
    pt = 7.5
    while pt <= 12:
        px = pt * ppi / 72
        print(f"{pt:4.1f}(磅) => {px:.3f}(px) => {int(px + 0.5)}(px)")
        pt += 0.5

# 显示不同视力观看相同ppi屏幕时，需要距离多远可以认为该屏幕是视网膜屏
def print_retina(ppi):
    mm = inch_2_mm / ppi
    m = mm / 1000
    angle = 3.0 / 10000 # 人眼最小视角
    print("\n不同视力超过该距离观看就属于视网膜屏:")

    eyes = [[1.0, 5.0], [0.8, 4.9], [0.6, 4.8], [0.5, 4.7], [0.4, 4.6], [0.3, 4.5]]
    for a, b in eyes:
        distance = m / (angle / a) * 100
        print(f"{b:.1f} 视力推荐距离: {distance:.2f}厘米", end="\t")
        print_scale(distance)

# 显示当前屏幕大小下推荐的观看距离，在这个距离以上可以不用移动脑袋即可舒适观看
def get_distance(W, H, diagonal) -> float:
    # 垂直方向角度转换为弧度
    angle = 15 * math.pi / 180  # 理论垂直舒适角度为上下各15度
    distance_V = (H / 2) / math.tan(angle) / 1000
    # print(f"垂直方向视角距离: {distance_V:.2f}m")

    # 水平方向角度转换为弧度
    angle = 25 * math.pi / 180  # 理论水平舒适角度为左右各30度，20度更佳
    distance_H = (W / 2) / math.tan(angle) / 1000
    # print(f"水平方向视角距离: {distance_H:.2f}m")

    return max(distance_V, distance_H)

def calc_monitor_parm(px_w, px_h, inch):
    # 计算PPI
    ppi = ((px_w ** 2 + px_h ** 2) ** 0.5) / inch

    # 计算宽高比，然后根据宽高比和对角线长度(inch)计算屏幕实际长与宽
    ratio = px_w / px_h
    diagonal = inch * inch_2_mm # 对角线长度转换为mm
    H = math.sqrt((diagonal ** 2) / (1 + ratio ** 2))
    W = ratio * H

    rec_distance = get_distance(W, H, diagonal)

    return W, H, ppi, rec_distance

# 获取参数，参数为: 分辨率W，分辨率H，大小(inch)，观看距离(m)
def __main__():
    import sys
    if len(sys.argv) != 5:
        print("Usage: python ppi.py <分辨率W> <分辨率H> <大小(inch)> <观看距离(m)>")
        return
    px_w = int(sys.argv[1])
    px_h = int(sys.argv[2])
    inch = float(sys.argv[3])
    cur_distance = float(sys.argv[4])

    size_w, size_h, ppi, rec_distance = calc_monitor_parm(px_w, px_h, inch)
    print(f"屏幕宽: {size_w:.2f}mm\
        屏幕高: {size_h:.2f}mm\
        DPI/PPI: {ppi:.2f}\
        推荐最小观看距离: {rec_distance:.2f}m\n")

    print(f"当前距离屏幕{cur_distance:.2f}厘米，", end="")
    print_scale(cur_distance)

    print_retina(ppi)

    print_px_scale(ppi)

if __name__ == '__main__':
    __main__()
