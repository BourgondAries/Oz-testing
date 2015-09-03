functor
import
	Application
	Browser
	System
define

	\insert List.oz

	fun {GetMain State}
		case State of state(main:X ...) then
			X
		else nil end
	end

	fun {GetA State}
		case State of state(trackA:X ...) then
			X
		else nil end
	end

	fun {GetB State}
		case State of state(trackB:X ...) then
			X
		else nil end
	end

	fun {GetTrack Track}
		case Track of trackA(N) then N
		[] trackB(N) then N end
	end

	fun {ApplyMoves State Moves}
		case Moves of Move|RemainingMoves then
			local NewState
				NewState = {ApplyMoves State Move}
			in
				case RemainingMoves of Mv|Rm then
					State|{ApplyMoves NewState RemainingMoves}
				else
					State|NewState|{ApplyMoves NewState RemainingMoves}
				end
			end
		[] trackA(N) then
			if N>0 then
				local A X L Y T Z B
					A = {GetA State}
					X = {GetMain State}
					L = {Length X}
					Y = {Drop X L-N}
					T = {Append Y A}
					Z = {Take X L-N}
					B = {GetB State}
				in
					state(main:Z trackA:T trackB:B)
				end
			elseif N<0 then
				local
					A = {GetA State}
					X = {GetMain State}
					L = {Length X}
					NewA = {Drop A ~N}
					MovedA = {Take A ~N}
					Z = {Append X MovedA}
					B = {GetB State}
				in
					state(main:Z trackA:NewA trackB:B)
				end
			else nil end
		[] trackB(N) then
			if N>0 then
				local A X L Y T Z B
					A = {GetB State}
					X = {GetMain State}
					L = {Length X}
					Y = {Drop X L-N}
					T = {Append Y A}
					Z = {Take X L-N}
					B = {GetA State}
				in
					state(main:Z trackA:B trackB:T)
				end
			elseif N<0 then
				local
					A = {GetA State}
					X = {GetMain State}
					L = {Length X}
					B = {GetB State}
					NewB = {Drop B ~N}
					MovedA = {Take B ~N}
					Z = {Append X MovedA}
				in
					state(main:Z trackA:A trackB:NewB)
				end
			else nil end
		else nil end
	end

	fun {SplitTrain Xs Y}
		local
			Pos = {Position Xs Y}
			Hs = {Take Xs Pos-1}
			Ts = {Drop Xs Pos}
			Head = if {Length Hs} > 0 then Hs else [nil] end
			Tail = if {Length Ts} > 0 then Ts else [nil] end
		in
			Head|Tail
		end
	end

/*
	fun {OptimizeTracks List}
		local
			First = {Take List 1}
			Second = {Take {Drop List 1} 1}
		in
			case First of trackA(N) then
				case Second of trackA(M) then
					trackA(N+M)
				else
					trackB(M)
				end
			case First of trackB(N) then
				case Second of trackB(M) then
					trackB(N+M)
				else
					trackA(M)
				end
			else
				nil
			end
		end
	end
*/

	fun {PrintListPure List}
		case List of X|Xs then
			X # ", " # {PrintListPure Xs}
		else "" end
	end

	fun {PrintStatePure State}
		local
			A = {GetA State}
			B = {GetB State}
			X = {GetMain State}
		in
			"main: " # {PrintListPure X} #
			"trackA: " # {PrintListPure A} #
			"trackB: " # {PrintListPure B} # "\n"
		end
	end

	fun {PrintStatesPure StateList N}
		case StateList of State|List then
			local
				Name = "State number: " # {IntToString N} # " - "
			in
				Name # {PrintStatePure State} # {PrintStatesPure List N+1}
			end
		else "" end
	end

	fun {PrintTrackListPure Tracks}
		case Tracks of X|Xs then
			{PrintTrackListPure X} # {PrintTrackListPure Xs}
		[] trackA(N ...) then
			"trackA(" # {IntToString N} # "), "
		[] trackB(N ...) then
			"trackB(" # {IntToString N} # "), "
		else
			nil
		end
	end

	fun {FindCar Xs Ys}
		case Xs of nil then nil
		[] X|Xt then
			case Ys of Y|Yz then
				if Ys==Xs then
					{FindCar Xt Yz}
				else
					local
						A = {SplitTrain Xs Y}
						AfterY = {Nth A 2}
						BeforeY = {Nth A 1}
						YWithAfterYCount = {Length AfterY}+1
						BeforeYCount = {Length BeforeY}
						NewState = AfterY#BeforeY
					in
						trackA(YWithAfterYCount)|trackB(BeforeYCount)|trackA(~YWithAfterYCount)|trackB(~BeforeYCount)|{FindCar NewState Yz}
					end
				end
			else nil end
		else nil end
	end


	local
		State = state(main:[a b] trackA:nil trackB:nil)
		Mvs = [trackA(1) trackB(1) trackA(~1)]
		NewStateList = {ApplyMoves State Mvs}
	in
		{System.showInfo {PrintStatesPure NewStateList 1}}
		{System.showInfo {PrintTrackListPure Mvs}}
	end

	{System.showInfo {PrintTrackListPure {FindCar [a b] [b a]}}}
	{Application.exit 0}
end
