/* Tooltip container */
.tooltip {
    position: relative;
    display: inline;
}

/* Tooltip Unordered List */
ul.tooltip{
	text-align: left; 
	margin-top: 5px; 
	margin-bottom: 10px;
}

/* Tooltip text */
.tooltip .tooltiptext {
    width: 275px;
    visibility: hidden;
    font-style: italic;
    background-color: #e1f3f8;
    font-size: small;
    text-align: center;
    border: 1px solid black;
    border-radius: 6px;
    padding: 10px 10px 10px 10px;
    position: absolute;
    z-index: 1;
    left: 125%;

    box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
}

/* Show the tooltip text when you mouse over the tooltip container */
.tooltip:hover .tooltiptext {
    visibility: visible;
}

/* Tooltip Pointer Arrow */ 
.tooltip .tooltiptext::after {
    content: "";
    position: absolute;
    top: 50%;
    right: 100%;
    margin-top: -5px;
    border-width: 5px;
    border-style: solid;
    border-color: transparent black transparent transparent;
}

.usa-input-required .tooltiptext{
	left: 90%;
}

/* Added label CSS style */
label{
	max-width: 51rem;
}
