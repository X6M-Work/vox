Names= ...
   ['Andreas Schreiber';	...
   'Christian        '; ...
   'Denise Duhme     '; ...
   'Frank Wefers     '; ...
   'Kathrin          '; ...
   'Malte            '; ...
   'Marc             '; ...
   'Michael Oetjen   '; ...
   'Michael Otto     '; ...
   'Torsten          '; ...
   'Vera Berg        '; ...
   'Martin           '; ...
   'Achim            '];

num = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 14.2 14.4 14.6 14.8 15 15.2];

% unfiltered HNR
a	= [17.32	22.27	24.58	24.43	21.18	29.78	17.98	14.85	21.30	19.33	12.74	26.22	20.61];
e	= [20.65	27.84	26.16	23.08	20.83	29.34	18.47	20.04	16.56	16.33	20.77	24.39	22.95];
i	= [27.89	29.84	31.34	29.52	21.50	28.23	19.77	26.95	28.80	19.96	23.06	13.23	18.41];
o	= [23.93	18.15	28.17	16.10	22.10	32.79	23.65	NaN 	27.44	10.23	22.35	NaN 	27.34];
u	= [26.04	NaN 	NaN 	NaN 	22.50	27.58	27.27	NaN 	23.71	28.00	23.12	NaN 	20.78];
ae= [24.08	24.08	27.36	23.31	13.32	27.77	20.50	15.01	15.39	11.86	13.05	26.19	20.78];
p	= [20.93	28.99	28.92	25.14	13.66	32.94	22.25	13.85	23.55	20.25	16.70	27.87	25.78];


% filtered HNR
% a = [23.15	27.96	26.54	30.07	25.65	36.98	23.95	21.93	27.59	24.17	16.98	29.99	28.88];
% e = [21.82	30.07	26.88	27.10	22.75	30.49	19.75	23.40	16.58	16.85	21.75	30.98	24.68];
% i = [29.43	32.09	32.76	31.59	24.18	29.28	20.34	27.99	30.27	19.96	23.82	15.94	21.65];
% o = [33.20	37.90	45.17	36.28	24.36	42.82	33.40	NaN 	39.90	28.13	32.21	NaN 	42.21];
% u = [42.65	NaN 	NaN 	NaN 	24.40	42.57	40.58	NaN 	41.92	39.19	35.31	NaN 	35.55];
% ae= [26.57	26.57	30.26	27.11	19.46	29.31	23.26	20.40	16.03	11.75	13.46	29.69	35.55];
% p = [25.97	40.59	36.73	34.50	19.67	47.37	31.67	25.50	32.71	28.63	23.82	33.38	34.71];


a_av = mean(a(find(a>0)));
e_av = mean(e(find(e>0)));
i_av = mean(i(find(i>0)));
o_av = mean(o(find(o>0)));
u_av = mean(u(find(u>0)));
aeav = mean(ae(find(ae>0)));
p_av = mean(p(find(p>0)));

a_st = std(a(find(a>0)),1);
e_st = std(e(find(e>0)),1);
i_st = std(i(find(i>0)),1);
o_st = std(o(find(o>0)),1);
u_st = std(u(find(u>0)),1);
aest = std(ae(find(ae>0)),1);
p_st = std(p(find(p>0)),1);

hold off
idx=1;plot([num(1:13) num(13+idx)], [a, a_av], 'dk'); hold on
idx=2;plot([num(1:13) num(13+idx)], [e, e_av], 'xk'); hold on
idx=3;plot([num(1:13) num(13+idx)], [i, i_av], '*k'); hold on
idx=4;plot([num(1:13) num(13+idx)], [o, o_av], '^k'); hold on
idx=5;plot([num(1:13) num(13+idx)], [u, u_av], 'ok'); hold on
idx=6;plot([num(1:13) num(13+idx)], [ae,aeav], '>k'); hold on
idx=7;plot([num(1:13) num(13+idx)], [p, p_av], 'sk');
legend(['a  '; 'e  '; 'i  '; 'o  '; 'u  '; 'ae '; 'pow'],3)
idx=1; line([num(13+idx) num(13+idx)], [a_av-a_st a_av+a_st]);
idx=2; line([num(13+idx) num(13+idx)], [e_av-e_st e_av+e_st]);
idx=3; line([num(13+idx) num(13+idx)], [i_av-i_st i_av+i_st]);
idx=4; line([num(13+idx) num(13+idx)], [o_av-o_st o_av+o_st]);
idx=5; line([num(13+idx) num(13+idx)], [u_av-u_st u_av+u_st]);
idx=6; line([num(13+idx) num(13+idx)], [aeav-aest aeav+aest]);
idx=7; line([num(13+idx) num(13+idx)], [p_av-p_st p_av+p_st]);
