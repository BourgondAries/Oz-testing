fun {LengthInternal Xs N}
	case Xs of X|Xx then
		{LengthInternal Xx N+1}
	else N end
end

fun {Length Xs}
	case Xs of X|Xx then
		{LengthInternal Xx 1}
	else 0 end
end

fun {Take Xs N}
	case Xs of X|Xx then
		if N > 0 then X|{Take Xx N-1}
		else nil end
	else nil end
end

fun {Drop Xs N}
	case Xs of X|Xx then
		if N > 0 then {Drop Xx N-1}
		else X|Xx end
	else nil end
end

fun {Append Xs Ys}
	case Xs of X|Xx then
		X|{Append Xx Ys}
	else
		case Ys of Y|Yx then
			Y|{Append Xs Yx}
		else
			nil
		end
	end
end

fun {Member Xs Y}
	case Xs of X|Xx then
		if Y==X then true
		else {Member Xx Y} end
	else false end
end

fun {PositionInternal Xs Y N}
	case Xs of X|Xx then
		if Y==X then N
		else {PositionInternal Xx Y N+1} end
	else ~1 end
end

fun {Position Xs Y}
	{PositionInternal Xs Y 1}
end
