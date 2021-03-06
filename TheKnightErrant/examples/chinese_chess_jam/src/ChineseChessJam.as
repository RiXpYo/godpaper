/**
 *  GODPAPER Confidential,Copyright 2012. All rights reserved.
 *
 *  Permission is hereby granted, free of charge, to any person obtaining
 *  a copy of this software and associated documentation files (the "Software"),
 *  to deal in the Software without restriction, including without limitation
 *  the rights to use, copy, modify, merge, publish, distribute, sub-license,
 *  and/or sell copies of the Software, and to permit persons to whom the
 *  Software is furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included
 *  in all copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 *  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 *  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
 *  IN THE SOFTWARE.
 */
package
{
	import com.godpaper.as3.configs.BoardConfig;
	import com.godpaper.as3.configs.GasketConfig;
	import com.godpaper.as3.configs.LoggerConfig;
	import com.godpaper.as3.configs.PieceConfig;
	import com.godpaper.as3.configs.PluginConfig;
	import com.godpaper.as3.configs.ServiceConfig;
	import com.godpaper.as3.configs.TextureConfig;
	import com.godpaper.as3.core.IChessPieceManager;
	import com.godpaper.as3.plugins.playerIO.PlayerIoPlugin;
	import com.godpaper.as3.utils.LogUtil;
	import com.godpaper.chinese_chess_jam.business.factory.ChessFactory_ChineseChessJam;
	import com.godpaper.chinese_chess_jam.business.managers.ChessPieceManager_ChineseChessJam;
	import com.godpaper.chinese_chess_jam.service.ChineseChessJamService;
	
	import mx.logging.ILogger;
	import mx.logging.LogEventLevel;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	
	/**
	 * ChineseChessJam.as class.   
	 * @see http://www.godpaper.com/godpaper/index.php/中国象棋	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Jul 3, 2012 4:16:34 PM
	 */   
	[SWF(frameRate="60", width="510", height="610", backgroundColor="0xffffff")]//320×480 for iPhone devices
//		[SWF(frameRate="60", width="600", height="636", backgroundColor="0xffffff")]//384×512 for iPad devices
	public class ChineseChessJam extends ApplicationBase
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(ChineseChessJam);
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		/**
		 * Override this for customize chess pieces manager.
		 */ 
		override public function get chessPiecesManager():IChessPieceManager
		{
			return new ChessPieceManager_ChineseChessJam();
		}
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//-------------------------------------------------------------------------- 
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function ChineseChessJam()
		{
			super();
		}     	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		override protected function initializeHandler():void
		{
			//config initialization here.
			//about chess board:
			BoardConfig.xLines=9;
			BoardConfig.yLines=10;
			BoardConfig.xOffset=55;
			BoardConfig.yOffset=55;
			//			BoardConfig.width=300;
			//			BoardConfig.height=300;
			BoardConfig.xScale=1;
			BoardConfig.yScale=1;
			BoardConfig.xAdjust=35;
			BoardConfig.yAdjust=30;
			BoardConfig.backgroundImageRequired = true;
//			BoardConfig.xOffset=this.width/10;
//			BoardConfig.yOffset=this.height/11;
//			BoardConfig.xAdjust=this.width/10;
//			BoardConfig.yAdjust=0;
			//Customize starling texture sample:
			//			var texture:Texture = AssetEmbedsDefault.getTexture(DefaultConstants.IMG_BACK_GROUND);
			//			BoardConfig.backgroundImage = new Image(texture);
			//gasket config:
			GasketConfig.maxPoolSize = 36;
			GasketConfig.tipsVisible = true;
			GasketConfig.backgroundAlpha = 0.0;
			GasketConfig.width = 30;
			GasketConfig.height = 30;
//			GasketConfig.borderVisible = true;
			//about service:
			ServiceConfig.wrapper = ChineseChessJamService;
			//about piece:
			PieceConfig.factory = ChessFactory_ChineseChessJam;
			PieceConfig.maxPoolSizeBlue = 16;
			PieceConfig.maxPoolSizeRed = 16;
			//Notice:starling scaleX/Y seldom triggle touch event issues.
			PieceConfig.scaleX = 1;
			PieceConfig.scaleY = 1;
			//about plugin:
			PluginConfig.gameID = "chinesechessjam-msf2zuz0suaip7yhtzpaa";//your custom game related id.
			PluginConfig.boardID = "ChineseChessJam";//your custom game related board id.
			PluginConfig.PGN_file = "../examples/chinese_chess_jam/assets/PGNs/N01顺炮横车破直车弃马局(UTF8).PGN";////和合二炮(utf8).PGN//N01顺炮横车破直车弃马局(UTF8).PGN
			//
			this._pluginProvider = new PlayerIoPlugin(PluginConfig.gameID,PluginConfig.boardID);//For playerIO plugin
			this._mochiads_game_id = "47de4a85dd3e213a";//espical for mochi game platform.
			//TextureConfig
			TextureConfig.AssetEmbeds_1x_class = AssetEmbeds_1x_chinese_chess_jam;
			TextureConfig.AssetEmbeds_2x_class = AssetEmbeds_2x_chinese_chess_jam;
			//
//			LOG.debug("SigletonFactory(cp) test:{0}",FlexGlobals.chessPiecesModel.BLUE_BISHOP.dump());
//			LOG.debug("SigletonFactory(cg) test:{0}",FlexGlobals.chessGasketsModel.gaskets);
//			LOG.debug("SigletonFactory(cb) test:{0}",FlexGlobals.chessBoardModel.status.dump());
			//LoggerConfig
//			LoggerConfig.filters = ["com.godpaper.chinese_chess_jam.business.*"];
			LoggerConfig.filters = ["*"];
			LoggerConfig.level = LogEventLevel.DEBUG;
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}
	
}