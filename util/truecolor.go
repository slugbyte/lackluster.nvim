package main

import (
	"fmt"
	"strconv"
)

const TERM_RESET = "\033[0m"

func assert(err error, msg string) {
	if err != nil {
		fmt.Println(err)
		panic(msg)
	}
}

func parseHexcode(color string) (r int64, g int64, b int64) {
	if len(color) != 6 {
		panic(fmt.Sprintf("(%s) is not a valid color", color))
	}
	var err error
	r, err = strconv.ParseInt(color[0:2], 16, 32)
	assert(err, "failed to parse red")

	g, err = strconv.ParseInt(color[2:4], 16, 32)
	assert(err, "failed to parse 64")

	b, err = strconv.ParseInt(color[4:6], 16, 64)
	assert(err, "failed to parse red")

	return r, g, b
}

type Color struct {
	Name    string
	Hexcode string
	R       int64
	G       int64
	B       int64
	parsed  bool
}

func (self *Color) Parse() {
	self.R, self.G, self.B = parseHexcode(self.Hexcode)
	self.parsed = true
}

// escaped termcolor code
func (self Color) TermcolorEscape() string {
	if !self.parsed {
		panic("color needs to be parsed before calling termcolorForeground")
	}
	return fmt.Sprintf("\\033[38;2;%d;%d;%dm", self.R, self.G, self.B)
}

// actual termcolor code
func (self Color) Termcolor() string {
	if !self.parsed {
		panic("color needs to be parsed before calling termcolorForeground")
	}
	return fmt.Sprintf("\033[38;2;%d;%d;%dm", self.R, self.G, self.B)
}

func (self Color) Header() string {
	if !self.parsed {
		panic("color needs to be parsed before calling termcolorForeground")
	}
	return fmt.Sprintf(
		"%sname:%s %-7s",
		self.Termcolor(),
		TERM_RESET,
		self.Name,
	)

}
func (self Color) RGB() string {
	if !self.parsed {
		panic("color needs to be parsed before calling Rgb")
	}
	return fmt.Sprintf("rgb(%d, %d, %d)", self.R, self.G, self.B)
}

func (self Color) String() string {
	if !self.parsed {
		panic("color needs to be parsed before calling String")
	}
	return fmt.Sprintf(
		"%s #%s %-18s %s",
		self.Header(),
		self.Hexcode,
		self.RGB(),
		self.TermcolorEscape(),
	)
}

func main() {
	color_list := []Color{
		{Name: "lack", Hexcode: "708090"},
		{Name: "luster", Hexcode: "deeeed"},
		{Name: "orange", Hexcode: "ffaa88"},
		{Name: "green", Hexcode: "789978"},
		{Name: "blue", Hexcode: "7788AA"},
		{Name: "red", Hexcode: "D70000"},
		{Name: "black", Hexcode: "000000"},
		{Name: "gray1", Hexcode: "080808"},
		{Name: "gray2", Hexcode: "191919"},
		{Name: "gray3", Hexcode: "2a2a2a"},
		{Name: "gray4", Hexcode: "444444"},
		{Name: "gray5", Hexcode: "555555"},
		{Name: "gray6", Hexcode: "7a7a7a"},
		{Name: "gray7", Hexcode: "aaaaaa"},
		{Name: "gray8", Hexcode: "cccccc"},
		{Name: "gray9", Hexcode: "DDDDDD"},
	}

	for _, color := range color_list {
		color.Parse()
		fmt.Println(color)
	}
}
