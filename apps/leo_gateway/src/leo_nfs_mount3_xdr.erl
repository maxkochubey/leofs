%%
%% src/leo_nfs_mount3_xdr was generated by erpcgen (do not edit)
%%
-module(leo_nfs_mount3_xdr).
-export([enc_fhandle/1, dec_fhandle/2]).
-export([enc_fhandle3/1, dec_fhandle3/2]).
-export([enc_fhstatus/1, dec_fhstatus/2]).
-export([enc_mountstat3/1, dec_mountstat3/2, dec_mountstat3_i2a/1]).
-export([enc_mountres3_ok/1, dec_mountres3_ok/2]).
-export([enc_mountres3/1, dec_mountres3/2]).
-export([enc_dirpath/1, dec_dirpath/2]).
-export([enc_name/1, dec_name/2]).
-export([enc_mountbody/1, dec_mountbody/2]).
-export([enc_groupnode/1, dec_groupnode/2]).
-export([enc_exportnode/1, dec_exportnode/2]).

enc_fhandle(_1) ->
    case io_list_len(_1) of
        32 ->
            _1;
        _ ->
            exit({xdr,limit})
    end.

dec_fhandle(_1, _2) ->
    begin
        <<_:_2/binary,_3:32/binary,_/binary>> = _1,
        {_3,_2 + 32}
    end.

enc_fhandle3(_1) ->
    begin
        _2 = io_list_len(_1),
        if
            _2 =< 64 ->
                [<<_2:32/unsigned>>,_1,enc_align(_2)];
            true ->
                exit({xdr,limit})
        end
    end.

dec_fhandle3(_1, _2) ->
    begin
        <<_:_2/binary,_3:32/unsigned,_/binary>> = _1,
        if
            _3 > 64 ->
                exit({xdr,limit});
            true ->
                _4 = _2 + 4,
                <<_:_4/binary,_5:_3/binary,_/binary>> = _1,
                {_5,_4 + align(_3)}
        end
    end.

enc_fhstatus(_1) ->
    case _1 of
        {_2,_3} ->
            [<<_2:32>>,
             case _2 of
                 0 ->
                     enc_fhandle(_3);
                 _ ->
                     []
             end]
    end.

dec_fhstatus(_1, _2) ->
    begin
        <<_:_2/binary,_3:32/unsigned,_/binary>> = _1,
        _6 = _2 + 4,
        case _3 of
            0 ->
                {_4,_5} = dec_fhandle(_1, _6),
                {{0,_4},_5};
            _ ->
                {_4,_5} = {void,_6},
                {{_3,_4},_5}
        end
    end.

enc_mountstat3(_1) ->
    case _1 of
        'MNT3_OK' ->
            <<0:32>>;
        'MNT3ERR_PERM' ->
            <<1:32>>;
        'MNT3ERR_NOENT' ->
            <<2:32>>;
        'MNT3ERR_IO' ->
            <<5:32>>;
        'MNT3ERR_ACCES' ->
            <<13:32>>;
        'MNT3ERR_NOTDIR' ->
            <<20:32>>;
        'MNT3ERR_INVAL' ->
            <<22:32>>;
        'MNT3ERR_NAMETOOLONG' ->
            <<63:32>>;
        'MNT3ERR_NOTSUPP' ->
            <<10004:32>>;
        'MNT3ERR_SERVERFAULT' ->
            <<10006:32>>
    end.

dec_mountstat3(_1, _2) ->
    begin
        <<_:_2/binary,_3:32,_/binary>> = _1,
        case _3 of
            0 ->
                {'MNT3_OK',_2 + 4};
            1 ->
                {'MNT3ERR_PERM',_2 + 4};
            2 ->
                {'MNT3ERR_NOENT',_2 + 4};
            5 ->
                {'MNT3ERR_IO',_2 + 4};
            13 ->
                {'MNT3ERR_ACCES',_2 + 4};
            20 ->
                {'MNT3ERR_NOTDIR',_2 + 4};
            22 ->
                {'MNT3ERR_INVAL',_2 + 4};
            63 ->
                {'MNT3ERR_NAMETOOLONG',_2 + 4};
            10004 ->
                {'MNT3ERR_NOTSUPP',_2 + 4};
            10006 ->
                {'MNT3ERR_SERVERFAULT',_2 + 4}
        end
    end.

dec_mountstat3_i2a(_4) ->
    case _4 of
        0 ->
            'MNT3_OK';
        1 ->
            'MNT3ERR_PERM';
        2 ->
            'MNT3ERR_NOENT';
        5 ->
            'MNT3ERR_IO';
        13 ->
            'MNT3ERR_ACCES';
        20 ->
            'MNT3ERR_NOTDIR';
        22 ->
            'MNT3ERR_INVAL';
        63 ->
            'MNT3ERR_NAMETOOLONG';
        10004 ->
            'MNT3ERR_NOTSUPP';
        10006 ->
            'MNT3ERR_SERVERFAULT'
    end.

enc_mountres3_ok(_1) ->
    case _1 of
        {_5,_2} ->
            [enc_fhandle3(_5),
             begin
                 _4 = length(_2),
                 [<<_4:32/unsigned>>,
                  lists:map(fun(_3) ->
                                   <<_3:32>>
                            end,
                            _2)]
             end]
    end.

dec_mountres3_ok(_1, _2) ->
    begin
        {_3,_4} = dec_fhandle3(_1, _2),
        {_5,_6} =
            begin
                <<_:_4/binary,_7:32/unsigned,_/binary>> = _1,
                map_elem(fun(_8, _9) ->
                                begin
                                    <<_:_9/binary,_10:32/signed,_/binary>> =
                                        _8,
                                    {_10,_9 + 4}
                                end
                         end,
                         _1,
                         _4 + 4,
                         infinity,
                         _7)
            end,
        {{_3,_5},_6}
    end.

enc_mountres3(_1) ->
    case _1 of
        {_2,_3} ->
            [enc_mountstat3(_2),
             case _2 of
                 'MNT3_OK' ->
                     enc_mountres3_ok(_3);
                 _ ->
                     []
             end]
    end.

dec_mountres3(_1, _2) ->
    begin
        <<_:_2/binary,_3:32/signed,_/binary>> = _1,
        _6 = _2 + 4,
        case _3 of
            0 ->
                {_4,_5} = dec_mountres3_ok(_1, _6),
                {{'MNT3_OK',_4},_5};
            _ ->
                {_4,_5} = {void,_6},
                _7 = dec_mountstat3_i2a(_3),
                {{_7,_4},_5}
        end
    end.

enc_dirpath(_1) ->
    begin
        _2 = io_list_len(_1),
        if
            _2 =< 1024 ->
                [<<_2:32/unsigned>>,_1,enc_align(_2)];
            true ->
                exit({xdr,limit})
        end
    end.

dec_dirpath(_1, _2) ->
    begin
        <<_:_2/binary,_3:32/unsigned,_/binary>> = _1,
        if
            _3 > 1024 ->
                exit({xdr,limit});
            true ->
                _4 = _2 + 4,
                <<_:_4/binary,_5:_3/binary,_/binary>> = _1,
                {_5,_4 + align(_3)}
        end
    end.

enc_name(_1) ->
    begin
        _2 = io_list_len(_1),
        if
            _2 =< 255 ->
                [<<_2:32/unsigned>>,_1,enc_align(_2)];
            true ->
                exit({xdr,limit})
        end
    end.

dec_name(_1, _2) ->
    begin
        <<_:_2/binary,_3:32/unsigned,_/binary>> = _1,
        if
            _3 > 255 ->
                exit({xdr,limit});
            true ->
                _4 = _2 + 4,
                <<_:_4/binary,_5:_3/binary,_/binary>> = _1,
                {_5,_4 + align(_3)}
        end
    end.

enc_mountbody(_1) ->
    case _1 of
        void ->
            <<0:32>>;
        _ ->
            [<<1:32>>,
             case _1 of
                 {_4,_3,_2} ->
                     [enc_name(_4),enc_dirpath(_3),enc_mountbody(_2)]
             end]
    end.

dec_mountbody(_1, _2) ->
    begin
        <<_:_2/binary,_3:32/unsigned,_/binary>> = _1,
        _4 = _2 + 4,
        if
            _3 == 0 ->
                {void,_4};
            _3 == 1 ->
                begin
                    {_5,_6} = dec_name(_1, _4),
                    {_7,_8} = dec_dirpath(_1, _6),
                    {_9,_10} = dec_mountbody(_1, _8),
                    {{_5,_7,_9},_10}
                end
        end
    end.

enc_groupnode(_1) ->
    case _1 of
        void ->
            <<0:32>>;
        _ ->
            [<<1:32>>,
             case _1 of
                 {_3,_2} ->
                     [enc_name(_3),enc_groupnode(_2)]
             end]
    end.

dec_groupnode(_1, _2) ->
    begin
        <<_:_2/binary,_3:32/unsigned,_/binary>> = _1,
        _4 = _2 + 4,
        if
            _3 == 0 ->
                {void,_4};
            _3 == 1 ->
                begin
                    {_5,_6} = dec_name(_1, _4),
                    {_7,_8} = dec_groupnode(_1, _6),
                    {{_5,_7},_8}
                end
        end
    end.

enc_exportnode(_1) ->
    case _1 of
        void ->
            <<0:32>>;
        _ ->
            [<<1:32>>,
             case _1 of
                 {_4,_3,_2} ->
                     [enc_dirpath(_4),
                      enc_groupnode(_3),
                      enc_exportnode(_2)]
             end]
    end.

dec_exportnode(_1, _2) ->
    begin
        <<_:_2/binary,_3:32/unsigned,_/binary>> = _1,
        _4 = _2 + 4,
        if
            _3 == 0 ->
                {void,_4};
            _3 == 1 ->
                begin
                    {_5,_6} = dec_dirpath(_1, _4),
                    {_7,_8} = dec_groupnode(_1, _6),
                    {_9,_10} = dec_exportnode(_1, _8),
                    {{_5,_7,_9},_10}
                end
        end
    end.

map_elem(Fun, Bin, Off, infinity, N) ->
  map_elem0(Fun, Bin, Off, N, []);
map_elem(Fun, Bin, Off, Max, N) when N =< Max ->
  map_elem0(Fun, Bin, Off, N, []).

map_elem0(_Fun, _Bin, Off, 0, L) ->
  {lists:reverse(L,[]), Off};
map_elem0(Fun, Bin, Off, N, L) ->
  {E,Off1} = Fun(Bin, Off),
map_elem0(Fun, Bin, Off1, N-1, [E|L]).

io_list_len(L) -> io_list_len(L, 0).
io_list_len([H|T], N) ->
  if
    H >= 0, H =< 255 -> io_list_len(T, N+1);
    is_list(H) -> io_list_len(T, io_list_len(H,N));
    is_binary(H) -> io_list_len(T, size(H) + N);
    true -> exit({xdr, opaque})
  end;
io_list_len(H, N) when is_binary(H) ->
  size(H) + N;
io_list_len([], N) ->
N.

enc_align(Len) ->
  case Len rem 4 of
    0 -> <<>>;
    1 -> <<0,0,0>>;
    2 -> <<0,0>>;
    3 -> <<0>>
  end.

align(Len) ->
  case Len rem 4 of
    0 -> Len;
    1 -> Len+3;
    2 -> Len+2;
    3 -> Len+1
  end.
