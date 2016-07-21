/*
 * Copyright (c) 2015, Nicolas Cannasse
 *
 * Permission to use, copy, modify, and/or distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
 * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR
 * IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */
package cdb;
import cdb.Data;

class TileBuilder {

	/*

		Bits

		1	2	4
		8	X	16
		32	64	128

		Corners

		┌  ─  ┐		0 1 2
		│  ■  │		3 8 4
		└  ─  ┘		5 6 7

		Lower Corners

		┌ ┐		9  10
		└ ┘		11 12

		U Corners

		   ┌ ┐			XX  13  XX
		┌       ┐		14  XX  15
		└       ┘
		   └ ┘			XX  16  XX

		Bottom

		└ - ┘			17 18 19


	*/

	private static inline var TOP_LEFT_BIT:Int	= 1; 	// 1 << 0; 
	private static inline var TOP_MID_BIT:Int	= 2;	// 1 << 1;
 	private static inline var TOP_RIGHT_BIT:Int	= 4;	// 1 << 2;
	private static inline var MID_LEFT_BIT:Int	= 8;	// 1 << 3;
	private static inline var MID_RIGHT_BIT:Int	= 16;	// 1 << 4;
	private static inline var LOW_LEFT_BIT:Int	= 32;	// 1 << 5;
	private static inline var LOW_MID_BIT:Int	= 64;	// 1 << 6;
	private static inline var LOW_RIGHT_BIT:Int	= 128;	// 1 << 7;

	private static inline var TOP_LEFT_CORNER:Int	= 0;
	private static inline var TOP_MID_CORNER:Int	= 1;
 	private static inline var TOP_RIGHT_CORNER:Int	= 2;
	private static inline var MID_LEFT_CORNER:Int	= 3;
	private static inline var MID_RIGHT_CORNER:Int	= 4;
	private static inline var LOW_LEFT_CORNER:Int	= 5;
	private static inline var LOW_MID_CORNER:Int	= 6;
	private static inline var LOW_RIGHT_CORNER:Int	= 7;

	private static inline var TOP_LEFT_LOWERCORNER:Int	= 9;
	private static inline var TOP_RIGHT_LOWERCORNER:Int	= 10;
	private static inline var LOW_LEFT_LOWERCORNER:Int	= 11;
	private static inline var LOW_RIGHT_LOWERCORNER:Int	= 12;

	private static inline var TOP_UCORNER:Int		= 13;
	private static inline var MID_LEFT_UCORNER:Int	= 14;
	private static inline var MID_RIGHT_UCORNER:Int	= 15;
	private static inline var LOW_UCORNER:Int		= 16;

	private static inline var LEFT_BOTTOM:Int		= 17;
	private static inline var MID_BOTTOM:Int		= 18;
	private static inline var RIGHT_BOTTOM:Int		= 19;

	var groundMap : Array<Int>;
	var groundIds = new Map<String, { id : Int, fill : Array<Int> }>();
	var borders = new Array<Array<Array<Int>>>();

	public function new( t : TilesetProps, stride : Int, total : Int ) {
		groundMap = [];
		for( i in 0...total+1 )
			groundMap[i] = 0;
		groundMap[0] = 0;
		borders = [];

		// get all grounds
		var tmp = new Map();
		for( s in t.sets )
			switch( s.t ) {
			case Ground if( s.opts.name != "" && s.opts.name != null ):
				var g = tmp.get(s.opts.name);
				if( g == null ) {
					g = [];
					tmp.set(s.opts.name, g);
				}
				g.push(s);
			default:
			}

		// sort by priority
		var allGrounds = Lambda.array(tmp);
		inline function ifNull<T>(v:Null<T>, def:T) return v == null ? def : v;
		allGrounds.sort(function(g1, g2) {
			var dp = ifNull(g1[0].opts.priority,0) - ifNull(g2[0].opts.priority,0);
			return dp != 0 ? dp : Reflect.compare(g1[0].opts.name, g2[0].opts.name);
		});

		// allocate group id
		var gid = 0;
		for( g in allGrounds ) {
			var p = ifNull(g[0].opts.priority, 0);
			if( p > 0 ) gid++;
			var fill = [];
			for( s in g )
				for( dx in 0...s.w )
					for( dy in 0...s.h ) {
						var tid = s.x + dx + (s.y + dy) * stride;
						fill.push(tid);
						groundMap[tid + 1] = gid;
					}
			groundIds.set(g[0].opts.name, { id : gid, fill : fill });
		}
		var maxGid = gid + 1;

		// save borders combos
		var allBorders = [];
		for( s in t.sets )
			if( s.t == Border )
				allBorders.push(s);
		inline function bweight(b) {
			var k = 0;
			if( b.opts.borderIn != null ) k += 1;
			if( b.opts.borderOut != null ) k += 2;
			if( b.opts.borderMode != null ) k += 4;
			if( b.opts.borderIn != null && b.opts.borderOut != null && b.opts.borderIn != "lower" && b.opts.borderOut != "upper" ) k += 8;
			return k;
		}
		allBorders.sort(function(b1, b2) {
			return bweight(b1) - bweight(b2);
		});
		for( b in allBorders ) {
			var gid = b.opts.borderIn == null ? null : groundIds.get(b.opts.borderIn); // if b.opts.borderIn == null, then gid = null, else gid = groundIds.get(b.opts.borderIn)
			var tid = b.opts.borderOut == null ? null : groundIds.get(b.opts.borderOut); // if b.opts.borderOut == null, then tid = null, else tid = groundIds.get(b.opts.borderOut)
			if( gid == null && tid == null ) continue;
			var gids, tids;
			if( gid != null )
				gids = [gid.id];
			else {
				switch( b.opts.borderIn ) {
				case null: gids = [for( g in tid.id + 1...maxGid ) g];
				case "lower": gids = [for( g in 0...tid.id ) g];
				default: continue;
				}
			}
			if( tid != null )
				tids = [tid.id];
			else {
				switch( b.opts.borderOut ) {
				case null: tids = [for( g in 0...gid.id ) g];
				case "upper": tids = [for( g in gid.id + 1...maxGid ) g];
				default: continue;
				}
			}
			var clear = gid != null && tid != null && b.opts.borderMode == null;
			switch( b.opts.borderMode ) {
			case "corner":
				// swap
				var tmp = gids;
				gids = tids;
				tids = tmp;
			default:
			}
			for( g in gids )
				for( t in tids ) {
					var bt = borders[g + t * 256];
					if( bt == null || clear ) {
						bt = [for( i in 0...20 ) []];
						if( gid != null ) bt[8] = gid.fill;
						borders[g + t * 256] = bt;
					}
					for( dx in 0...b.w )
						for( dy in 0...b.h ) {
							var k;
							switch( b.opts.borderMode ) {
							case null:
								if( dy == 0 )
									k = dx == 0 ? 0 : dx == b.w - 1 ? 2 : 1;
								else if( dy == b.h - 1 )
									k = dx == 0 ? LOW_LEFT_CORNER : dx == b.w - 1 ? LOW_RIGHT_CORNER : LOW_MID_CORNER;
								else if( dx == 0 )
									k = MID_LEFT_CORNER; //3
								else if( dx == b.w - 1 )
									k = MID_RIGHT_CORNER; //4
								else
									continue;
							case "corner":
								if( dx == 0 && dy == 0 )
									k = TOP_LEFT_LOWERCORNER; //9
								else if( dx == b.w - 1 && dy == 0 )
									k = TOP_RIGHT_LOWERCORNER; //10
								else if( dx == 0 && dy == b.h - 1 )
									k = LOW_LEFT_LOWERCORNER; //11
								else if( dx == b.w - 1 && dy == b.h - 1 )
									k = LOW_RIGHT_LOWERCORNER; //12
								else
									continue;
							case "u":
								if( dx == 1 && dy == 0 )
									k = TOP_UCORNER; //13
								else if( dx == 0 && dy == 1 )
									k = MID_LEFT_UCORNER; //14
								else if( dx == 2 && dy == 1 )
									k = MID_RIGHT_UCORNER; //15
								else if( dx == 1 && dy == 2 )
									k = LOW_UCORNER; //16
								else
									continue;
							case "bottom":
								k = dx == 0 ? LEFT_BOTTOM : dx == b.w - 1 ? RIGHT_BOTTOM : MID_BOTTOM;
							default:
								continue;
							}
							bt[k].push(b.x + dx + (b.y + dy) * stride);
						}
				}
		}
	}

	function random( n : Int ) {
		n *= 0xcc9e2d51;
		n = (n << 15) | (n >>> 17);
		n *= 0x1b873593;
		var h = 5381;
		h ^= n;
		h = (h << 13) | (h >>> 19);
		h = h*5 + 0xe6546b64;
		h ^= h >> 16;
		h *= 0x85ebca6b;
		h ^= h >> 13;
		h *= 0xc2b2ae35;
		h ^= h >> 16;
		return h;
	}

	/**
		Returns [X,Y,TileID] sets
	**/
	public function buildGrounds( input : Array<Int>, width : Int ) : Array<Int> {
		var height = Std.int(input.length / width);
		var p = -1;
		var out = [];
		for( y in 0...height )
			for( x in 0...width ) {
				var v = input[++p];
				var g = groundMap[v];
				var g_left = x == 0 ? g : groundMap[input[p - 1]]; // if x == 0, then g_left = g, else g_left = groundMap[input[p - 1]]
				var g_right = x == width - 1 ? g : groundMap[input[p + 1]]; //if x == width - 1, then g_right = g, else g_right = groundMap[input[p + 1]]
				var g_top = y == 0 ? g : groundMap[input[p - width]]; //if y == 0, then g_top = g, else g_top = groundMap[input[p - width]]
				var g_bottom = y == height - 1 ? g : groundMap[input[p + width]]; //if y == height - 1, then g_bottom = g, else g_bottom = groundMap[input[p + width]]

				var g_top_left = x == 0 || y == 0 ? g : groundMap[input[p - 1 - width]];
				var g_top_right = x == width - 1 || y == 0 ? g : groundMap[input[p + 1 - width]];
				var g_bottom_left = x == 0 || y == height-1 ? g : groundMap[input[p - 1 + width]];
				var g_bottom_right = x == width - 1 || y == height - 1 ? g : groundMap[input[p + 1 + width]];

				inline function max(a, b) return a > b ? a : b;
				inline function min(a, b) return a > b ? b : a;
				var max = max(max(max(g_right, g_left), max(g_top, g_bottom)), max(max(g_top_right, g_top_left), max(g_bottom_right, g_bottom_left)));
				var min = min(min(min(g_right, g_left), min(g_top, g_bottom)), min(min(g_top_right, g_top_left), min(g_bottom_right, g_bottom_left)));

				for( t in min...max + 1 ) {
					var bb = borders[t + g * 256];

					if( bb == null ) continue;

					var bits = 0;
					if( t == g_top_left )
						bits |= TOP_LEFT_BIT; //1
					if( t == g_top )
						bits |= TOP_MID_BIT; //2
					if( t == g_top_right )
						bits |= TOP_RIGHT_BIT; //4
					if( t == g_left )
						bits |= MID_LEFT_BIT; //8
					if( t == g_right )
						bits |= MID_RIGHT_BIT; //16
					if( t == g_bottom_left )
						bits |= LOW_LEFT_BIT; //32
					if( t == g_bottom )
						bits |= LOW_MID_BIT; //64
					if( t == g_bottom_right )
						bits |= LOW_RIGHT_BIT; //128

					inline function addTo( x : Int, y : Int, a : Array<Int> ) {
						out.push(x);
						out.push(y);
						out.push(a.length == 1 ? a[0] : a[random(x + y * width) % a.length]);
					}

					inline function add( a : Array<Int> ) {
						addTo(x, y, a);
					}

					inline function check( b, clear, k ) {
						var f = false;
						if( bits & b == b ) {
							var a = bb[k];
							if( a.length != 0 ) {
								bits &= ~(clear | b);
								add(a);
								f = true;
							}
						}
						return f;
					}

					check(TOP_MID_BIT | MID_LEFT_BIT | MID_RIGHT_BIT, TOP_LEFT_BIT | TOP_RIGHT_BIT, TOP_UCORNER)
					// check(2 | 8 | 16, 1 | 4, 13);
					check(TOP_MID_BIT | MID_LEFT_BIT | LOW_MID_BIT, TOP_LEFT_BIT | LOW_LEFT_BIT, MID_LEFT_UCORNER);
					// check(2 | 8 | 64, 1 | 32, 14);
					check(TOP_MID_BIT | MID_RIGHT_BIT | LOW_MID_BIT, TOP_RIGHT_BIT | LOW_RIGHT_BIT, MID_RIGHT_UCORNER);
					// check(2 | 16 | 64, 4 | 128, 15);
					check(MID_LEFT_BIT | MID_RIGHT_BIT | LOW_MID_BIT, LOW_LEFT_BIT | LOW_RIGHT_BIT, LOW_UCORNER);
					// check(8 | 16 | 64, 32 | 128, 16);

					check(TOP_MID_BIT | MID_LEFT_BIT, TOP_LEFT_BIT | TOP_RIGHT_BIT | LOW_LEFT_BIT, TOP_LEFT_LOWERCORNER);
					// check(2 | 8, 1 | 4 | 32, 9);
					check(TOP_MID_BIT | MID_RIGHT_BIT, TOP_LEFT_BIT | TOP_RIGHT_BIT | LOW_RIGHT_BIT, TOP_RIGHT_LOWERCORNER);
					// check(2 | 16, 1 | 4 | 128, 10);
					check(MID_LEFT_BIT | LOW_MID_BIT, TOP_LEFT_BIT | LOW_LEFT_BIT | LOW_RIGHT_BIT, LOW_LEFT_LOWERCORNER);
					// check(8 | 64, 1 | 32 | 128, 11);
					check(MID_RIGHT_BIT | LOW_MID_BIT, TOP_RIGHT_BIT | LOW_LEFT_BIT | LOW_RIGHT_BIT, LOW_RIGHT_LOWERCORNER);
					// check(16 | 64, 4 | 32 | 128, 12);

					if( check(TOP_MID_BIT, TOP_LEFT_BIT | TOP_RIGHT_BIT, LOW_MID_CORNER) ) 
					{
					// if( check(2, 1 | 4, 6) ) {
						var a = bb[18];
						if( a.length != 0 ) {
							out.push(x);
							out.push(y + 1);
							if( x > 0 && y > 0 && groundMap[input[p - 1 - width]] != t )
								out.push(a[0]);
							else if( x < width - 1 && y > 0 && groundMap[input[p + 1 - width]] != t )
								out.push(a[a.length - 1]);
							else if( a.length == 1 )
								out.push(a[0]);
							else
								out.push(a[1 + random(x + y * width) % (a.length - 2)]);
						}
					}

					check(MID_LEFT_BIT, TOP_LEFT_BIT | LOW_LEFT_BIT, MID_RIGHT_CORNER);
					// check(8, 1 | 32, 4);
					check(MID_RIGHT_BIT, TOP_RIGHT_BIT | LOW_RIGHT_BIT, MID_LEFT_CORNER);
					// check(16, 4 | 128, 3);
					check(LOW_MID_BIT, LOW_LEFT_BIT | LOW_RIGHT_BIT, TOP_MID_CORNER);
					// check(64, 32 | 128, 1);

					if( check(TOP_LEFT_BIT, TOP_LEFT_BIT, LOW_RIGHT_CORNER) ) {
					// if( check(1, 1, 7) ) {
						var a = bb[19];
						if( a.length != 0 )
							addTo(x, y + 1, a);
					}
					if( check(TOP_RIGHT_BIT, TOP_RIGHT_BIT, LOW_LEFT_CORNER) ) {
					// if( check(4, 4, 5) ) {
						var a = bb[17];
						if( a.length != 0 )
							addTo(x, y + 1, a);
					}
					check(LOW_LEFT_BIT, LOW_LEFT_BIT, TOP_RIGHT_CORNER);
					// check(32, 32, 2);
					check(LOW_RIGHT_BIT, LOW_RIGHT_BIT, TOP_LEFT_CORNER);
					// check(128, 128, 0);
				}
			}
		return out;
	}

}